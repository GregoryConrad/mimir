use std::{collections::HashMap, convert::TryInto, fs::create_dir_all, io::Cursor, path::Path};

use anyhow::{anyhow, Result};
use lazy_static::lazy_static;
use milli::{
    documents::{DocumentsBatchBuilder, DocumentsBatchReader},
    heed, update, AscDesc, Criterion, Index, Member, Search, SearchResult,
};
use parking_lot::RwLock;

use crate::api::{Filter, MimirIndexSettings, SortBy, Synonyms, TermsMatchingStrategy};

use super::Document;

pub struct EmbeddedMilli;

impl super::EmbeddedMilli for EmbeddedMilli {
    fn ensure_instance_initialized(instance_dir: &str) -> Result<()> {
        let instances = INSTANCES.read();

        // If this instance does not yet exist, create it
        if !instances.contains_key(instance_dir) {
            drop(instances); // prevent deadlock with the prev read lock and now write lock
            let mut instances = INSTANCES.write();

            // Perhaps the instance was initialized while we were waiting to get the lock
            // Now that we have the write lock, check that we actually need to do anything
            if !instances.contains_key(instance_dir) {
                create_dir_all(instance_dir)?;
                instances.insert(instance_dir.to_string(), Instance::new());
            }
        }

        Ok(())
    }

    fn ensure_index_initialized(instance_dir: &str, index_name: &str) -> Result<()> {
        Self::ensure_instance_initialized(instance_dir)?;
        let instances = INSTANCES.read();
        let indexes = &instances.get(instance_dir).unwrap().indexes;

        // If this index does not yet exist, create it
        if !indexes.contains_key(index_name) {
            drop(instances); // prevent deadlock with the prev read lock and now write lock
            let mut instances = INSTANCES.write();
            let indexes = &mut instances.get_mut(instance_dir).unwrap().indexes;

            // Perhaps the index was initialized while we were waiting to get the lock
            // Now that we have the write lock, check that we actually need to do anything
            if !indexes.contains_key(index_name) {
                let path = Path::new(instance_dir).join(index_name);
                create_dir_all(&path)?;
                let mut options = heed::EnvOpenOptions::new();
                options.map_size(super::MAX_MAP_SIZE);
                let index = Index::new(options, &path)?;
                indexes.insert(index_name.to_string(), RwLock::new(index));
            }
        }

        Ok(())
    }

    fn add_documents(
        instance_dir: String,
        index_name: String,
        documents: Vec<Document>,
    ) -> Result<()> {
        Self::ensure_index_initialized(&instance_dir, &index_name)?;
        let instances = INSTANCES.read();
        let index_lock = get_index_lock(&instances, &instance_dir, &index_name);
        let index = index_lock.write();

        // Create a batch builder to convert json_documents into milli's format
        let mut builder = DocumentsBatchBuilder::new(Vec::new());
        for doc in documents {
            builder.append_json_object(&doc)?;
        }

        // Flush the contents of the builder and retreive the buffer to make a batch reader
        let buff = builder.into_inner()?;
        let reader = DocumentsBatchReader::from_reader(Cursor::new(buff))?;

        // Create the configs needed for the batch document addition
        let indexer_config = update::IndexerConfig::default();
        let indexing_config = update::IndexDocumentsConfig::default();

        // Make an index write transaction with a batch step to index the new documents
        let mut wtxn = index.write_txn()?;
        update::IndexDocuments::new(
            &mut wtxn,
            &index,
            &indexer_config,
            indexing_config,
            |_| (),
            || false,
        )?
        .add_documents(reader)
        .map(|t| t.0)?
        .execute()?;

        wtxn.commit().map_err(anyhow::Error::from)
    }

    fn delete_documents(
        instance_dir: String,
        index_name: String,
        document_ids: Vec<String>,
    ) -> Result<()> {
        Self::ensure_index_initialized(&instance_dir, &index_name)?;
        let instances = INSTANCES.read();
        let index_lock = get_index_lock(&instances, &instance_dir, &index_name);
        let index = index_lock.write();

        let mut wtxn = index.write_txn()?;
        let mut builder = update::DeleteDocuments::new(&mut wtxn, &index)?;
        for doc_id in document_ids {
            builder.delete_external_id(&doc_id);
        }
        builder.execute()?;

        wtxn.commit().map_err(anyhow::Error::from)
    }

    fn delete_all_documents(instance_dir: String, index_name: String) -> Result<()> {
        Self::ensure_index_initialized(&instance_dir, &index_name)?;
        let instances = INSTANCES.read();
        let index_lock = get_index_lock(&instances, &instance_dir, &index_name);
        let index = index_lock.write();

        let mut wtxn = index.write_txn()?;
        let builder = update::ClearDocuments::new(&mut wtxn, &index);
        builder.execute()?;

        wtxn.commit().map_err(anyhow::Error::from)
    }

    fn set_documents(
        instance_dir: String,
        index_name: String,
        documents: Vec<Document>,
    ) -> Result<()> {
        Self::ensure_index_initialized(&instance_dir, &index_name)?;
        let instances = INSTANCES.read();
        let index_lock = get_index_lock(&instances, &instance_dir, &index_name);
        let index = index_lock.write();
        let mut wtxn = index.write_txn()?;

        // Delete all existing documents
        update::ClearDocuments::new(&mut wtxn, &index).execute()?;

        // Create a batch builder to convert json_documents into milli's format
        let mut builder = DocumentsBatchBuilder::new(Vec::new());
        for doc in documents {
            builder.append_json_object(&doc)?;
        }

        // Flush the contents of the builder and retreive the buffer to make a batch reader
        let buff = builder.into_inner()?;
        let reader = DocumentsBatchReader::from_reader(Cursor::new(buff))?;

        // Create the configs needed for the batch document addition
        let indexer_config = update::IndexerConfig::default();
        let indexing_config = update::IndexDocumentsConfig::default();

        // Make a batch step to index the new documents
        update::IndexDocuments::new(
            &mut wtxn,
            &index,
            &indexer_config,
            indexing_config,
            |_| (),
            || false,
        )?
        .add_documents(reader)
        .map(|t| t.0)?
        .execute()?;

        wtxn.commit().map_err(anyhow::Error::from)
    }

    fn get_document(
        instance_dir: String,
        index_name: String,
        document_id: String,
    ) -> Result<Option<Document>> {
        Self::ensure_index_initialized(&instance_dir, &index_name)?;
        let instances = INSTANCES.read();
        let index_lock = get_index_lock(&instances, &instance_dir, &index_name);
        let index = index_lock.read();

        let rtxn = index.read_txn()?;
        let fields_ids_map = index.fields_ids_map(&rtxn)?;
        let external_ids = index.external_documents_ids(&rtxn)?;
        let internal_id = match external_ids.get(document_id) {
            Some(id) => id,
            None => return Ok(None),
        };
        let documents = index.documents(&rtxn, vec![internal_id])?;
        let (_id, document) = documents
            .first()
            .ok_or_else(|| anyhow!("Missing document"))?;
        milli::all_obkv_to_json(*document, &fields_ids_map)
            .map(Some)
            .map_err(anyhow::Error::from)
    }

    fn get_all_documents(instance_dir: String, index_name: String) -> Result<Vec<Document>> {
        Self::ensure_index_initialized(&instance_dir, &index_name)?;
        let instances = INSTANCES.read();
        let index_lock = get_index_lock(&instances, &instance_dir, &index_name);
        let index = index_lock.read();

        let rtxn = index.read_txn()?;
        let fields_ids_map = index.fields_ids_map(&rtxn)?;
        let documents = index.all_documents(&rtxn)?;
        documents
            .map(|doc| milli::all_obkv_to_json(doc?.1, &fields_ids_map))
            .map(|r| r.map_err(anyhow::Error::from))
            .collect()
    }

    fn search_documents(
        instance_dir: String,
        index_name: String,
        query: Option<String>,
        limit: Option<u32>,
        sort_criteria: Option<Vec<SortBy>>,
        filter: Option<Filter>,
        matching_strategy: Option<TermsMatchingStrategy>,
    ) -> Result<Vec<Document>> {
        Self::ensure_index_initialized(&instance_dir, &index_name)?;
        let instances = INSTANCES.read();
        let index_lock = get_index_lock(&instances, &instance_dir, &index_name);
        let index = index_lock.read();

        // Create the search
        let rtxn = index.read_txn()?;
        let mut search = Search::new(&rtxn, &index);

        // Configure the search based on given parameters
        query.map(|q| search.query(q));
        search.limit(limit.unwrap_or(u32::MAX).try_into()?);
        matching_strategy
            .map(|s| s.to_milli())
            .map(|s| search.terms_matching_strategy(s));
        sort_criteria.map(|criteria| {
            let criteria = criteria
                .iter()
                .map(|criterion| match criterion {
                    SortBy::Asc(field) => AscDesc::Asc(Member::Field(field.clone())),
                    SortBy::Desc(field) => AscDesc::Desc(Member::Field(field.clone())),
                })
                .collect();
            search.sort_criteria(criteria)
        });
        filter
            .as_ref()
            .map(create_filter_condition)
            .map(|f| search.filter(f.into()));

        // Get the documents based on the search results
        let SearchResult { documents_ids, .. } = search.execute()?;
        let fields_ids_map = index.fields_ids_map(&rtxn)?;
        index
            .documents(&rtxn, documents_ids)?
            .iter()
            .map(|(_id, doc)| milli::all_obkv_to_json(*doc, &fields_ids_map))
            .map(|r| r.map_err(anyhow::Error::from))
            .collect()
    }

    fn get_settings(instance_dir: String, index_name: String) -> Result<MimirIndexSettings> {
        Self::ensure_index_initialized(&instance_dir, &index_name)?;
        let instances = INSTANCES.read();
        let index_lock = get_index_lock(&instances, &instance_dir, &index_name);
        let index = index_lock.read();

        let rtxn = index.read_txn()?;
        Ok(MimirIndexSettings {
            searchable_fields: index
                .searchable_fields(&rtxn)?
                .map(|fields| fields.into_iter().map(String::from).collect()),
            filterable_fields: index.filterable_fields(&rtxn)?.into_iter().collect(),
            sortable_fields: index.sortable_fields(&rtxn)?.into_iter().collect(),
            ranking_rules: index
                .criteria(&rtxn)?
                .into_iter()
                .map(|rule| match rule {
                    Criterion::Words => "words",
                    Criterion::Typo => "typo",
                    Criterion::Proximity => "proximity",
                    Criterion::Attribute => "attribute",
                    Criterion::Sort => "sort",
                    Criterion::Exactness => "exactness",
                    Criterion::Asc(_) => "",
                    Criterion::Desc(_) => "",
                })
                .filter(|s| !s.is_empty())
                .map(String::from)
                .collect(),
            stop_words: index
                .stop_words(&rtxn)?
                .map(|words| words.stream().into_strs())
                .unwrap_or_else(|| Ok(Vec::new()))?,
            synonyms: index
                .synonyms(&rtxn)?
                .into_iter()
                .map(|(word, synonyms)| {
                    (
                        word[0].clone(),
                        synonyms
                            .iter()
                            .flat_map(|v| v.iter())
                            .map(String::from)
                            .collect(),
                    )
                })
                .map(|(word, synonyms)| Synonyms { word, synonyms })
                .collect(),
            typos_enabled: index.authorize_typos(&rtxn)?,
            min_word_size_for_one_typo: index.min_word_len_one_typo(&rtxn)?,
            min_word_size_for_two_typos: index.min_word_len_two_typos(&rtxn)?,
            disallow_typos_on_words: index
                .exact_words(&rtxn)?
                .map(|words| words.stream().into_strs())
                .unwrap_or_else(|| Ok(Vec::new()))?,
            disallow_typos_on_fields: index
                .exact_attributes(&rtxn)?
                .into_iter()
                .map(String::from)
                .collect(),
        })
    }

    fn set_settings(
        instance_dir: String,
        index_name: String,
        settings: MimirIndexSettings,
    ) -> Result<()> {
        Self::ensure_index_initialized(&instance_dir, &index_name)?;
        let instances = INSTANCES.read();
        let index_lock = get_index_lock(&instances, &instance_dir, &index_name);
        let index = index_lock.write();

        // Destructure the settings into the corresponding fields
        let MimirIndexSettings {
            searchable_fields,
            filterable_fields,
            sortable_fields,
            ranking_rules,
            stop_words,
            synonyms,
            typos_enabled,
            min_word_size_for_one_typo,
            min_word_size_for_two_typos,
            disallow_typos_on_words,
            disallow_typos_on_fields,
        } = settings;

        // Set up the settings update
        let mut wtxn = index.write_txn()?;
        let indexer_config = update::IndexerConfig::default();
        let mut builder = update::Settings::new(&mut wtxn, &index, &indexer_config);

        // Copy over the given settings
        match searchable_fields {
            Some(fields) => builder.set_searchable_fields(fields),
            None => builder.reset_searchable_fields(),
        }
        builder.set_filterable_fields(filterable_fields.into_iter().collect());
        builder.set_sortable_fields(sortable_fields.into_iter().collect());
        builder.set_criteria(ranking_rules);
        builder.set_stop_words(stop_words.into_iter().collect());
        builder.set_synonyms(synonyms.into_iter().map(|s| (s.word, s.synonyms)).collect());
        builder.set_autorize_typos(typos_enabled);
        builder.set_min_word_len_one_typo(min_word_size_for_one_typo);
        builder.set_min_word_len_two_typos(min_word_size_for_two_typos);
        builder.set_exact_words(disallow_typos_on_words.into_iter().collect());
        builder.set_exact_attributes(disallow_typos_on_fields.into_iter().collect());

        // Execute the settings update
        builder.execute(|_| {}, || false)?;
        wtxn.commit().map_err(anyhow::Error::from)
    }
}

lazy_static! {
    /// The mapping of instance paths (directories) to instances
    static ref INSTANCES: RwLock<HashMap<String, Instance>> = RwLock::new(HashMap::new());
}

struct Instance {
    indexes: HashMap<String, RwLock<Index>>,
}

impl Instance {
    fn new() -> Instance {
        Instance {
            indexes: HashMap::new(),
        }
    }
}

fn get_index_lock<'a>(
    instances: &'a HashMap<String, Instance>,
    instance_dir: &'a str,
    index_name: &'a str,
) -> &'a RwLock<Index> {
    instances
        .get(instance_dir)
        .unwrap()
        .indexes
        .get(index_name)
        .unwrap()
}

impl TermsMatchingStrategy {
    fn to_milli(&self) -> milli::TermsMatchingStrategy {
        match self {
            TermsMatchingStrategy::Last => milli::TermsMatchingStrategy::Last,
            TermsMatchingStrategy::First => milli::TermsMatchingStrategy::First,
            TermsMatchingStrategy::Frequency => milli::TermsMatchingStrategy::Frequency,
            TermsMatchingStrategy::Size => milli::TermsMatchingStrategy::Size,
            TermsMatchingStrategy::Any => milli::TermsMatchingStrategy::Any,
            TermsMatchingStrategy::All => milli::TermsMatchingStrategy::All,
        }
    }
}

fn create_token(s: &String) -> filter_parser::Token {
    filter_parser::Span::new_extra(s, s).into()
}

fn create_condition<'a>(s: &'a String, cond: milli::Condition<'a>) -> milli::FilterCondition<'a> {
    milli::FilterCondition::Condition {
        fid: create_token(s),
        op: cond,
    }
}

fn create_filter_condition(f: &Filter) -> milli::FilterCondition {
    match f {
        Filter::Or(filters) => {
            milli::FilterCondition::Or(filters.iter().map(create_filter_condition).collect())
        }
        Filter::And(filters) => {
            milli::FilterCondition::And(filters.iter().map(create_filter_condition).collect())
        }
        Filter::Not(filter) => {
            milli::FilterCondition::Not(Box::new(create_filter_condition(filter)))
        }
        Filter::InValues { field, values } => milli::FilterCondition::In {
            fid: create_token(field),
            els: values.iter().map(create_token).collect(),
        },
        Filter::Exists { field } => create_condition(field, milli::Condition::Exists),
        Filter::GreaterThan { field, value } => {
            create_condition(field, milli::Condition::GreaterThan(create_token(value)))
        }
        Filter::GreaterThanOrEqual { field, value } => create_condition(
            field,
            milli::Condition::GreaterThanOrEqual(create_token(value)),
        ),
        Filter::Equal { field, value } => {
            create_condition(field, milli::Condition::Equal(create_token(value)))
        }
        Filter::NotEqual { field, value } => {
            create_condition(field, milli::Condition::NotEqual(create_token(value)))
        }
        Filter::LessThan { field, value } => {
            create_condition(field, milli::Condition::LowerThan(create_token(value)))
        }
        Filter::LessThanOrEqual { field, value } => create_condition(
            field,
            milli::Condition::LowerThanOrEqual(create_token(value)),
        ),
        Filter::Between { field, from, to } => create_condition(
            field,
            milli::Condition::Between {
                from: create_token(from),
                to: create_token(to),
            },
        ),
    }
}
