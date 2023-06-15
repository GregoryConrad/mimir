use milli_v1 as milli;

use std::{convert::TryInto, io::Cursor, path::Path, str::FromStr};

use anyhow::{anyhow, Result};
use milli::{
    documents::{DocumentsBatchBuilder, DocumentsBatchReader},
    heed, update, AscDesc, Criterion, Index, Member, Search, SearchResult,
};

use crate::api::{Filter, MimirIndexSettings, SortBy, Synonyms, TermsMatchingStrategy};

use super::{Document, Dump};

pub(crate) struct EmbeddedMilli;

impl super::EmbeddedMilli<Index> for EmbeddedMilli {
    fn create_index(dir: &std::path::Path) -> Result<Index> {
        std::fs::create_dir_all(dir)?;
        let mut options = heed::EnvOpenOptions::new();
        options.map_size(super::MAX_MAP_SIZE);

        Index::new(options, dir).map_err(anyhow::Error::from)
    }

    fn add_documents(index: &Index, documents: Vec<Document>) -> Result<()> {
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
        let (builder, indexing_result) = update::IndexDocuments::new(
            &mut wtxn,
            index,
            &indexer_config,
            indexing_config,
            |_| (),
            || false,
        )?
        .add_documents(reader)?;
        indexing_result?; // check to make sure there is no UserError
        builder.execute()?;

        wtxn.commit().map_err(Into::into)
    }

    fn delete_documents(index: &Index, document_ids: Vec<String>) -> Result<()> {
        let mut wtxn = index.write_txn()?;
        let mut builder = update::DeleteDocuments::new(&mut wtxn, index)?;
        for doc_id in document_ids {
            builder.delete_external_id(&doc_id);
        }
        builder.execute()?;

        wtxn.commit().map_err(anyhow::Error::from)
    }

    fn delete_all_documents(index: &Index) -> Result<()> {
        let mut wtxn = index.write_txn()?;
        let builder = update::ClearDocuments::new(&mut wtxn, index);
        builder.execute()?;

        wtxn.commit().map_err(anyhow::Error::from)
    }

    fn set_documents(index: &Index, documents: Vec<Document>) -> Result<()> {
        let mut wtxn = index.write_txn()?;

        // Delete all existing documents
        update::ClearDocuments::new(&mut wtxn, index).execute()?;

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
        let (builder, indexing_result) = update::IndexDocuments::new(
            &mut wtxn,
            index,
            &indexer_config,
            indexing_config,
            |_| (),
            || false,
        )?
        .add_documents(reader)?;
        indexing_result?; // check to make sure there is no UserError
        builder.execute()?;

        wtxn.commit().map_err(Into::into)
    }

    fn get_document(index: &Index, document_id: String) -> Result<Option<Document>> {
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

    fn get_all_documents(index: &Index) -> Result<Vec<Document>> {
        let rtxn = index.read_txn()?;
        let fields_ids_map = index.fields_ids_map(&rtxn)?;
        let documents = index.all_documents(&rtxn)?;
        documents
            .map(|doc| milli::all_obkv_to_json(doc?.1, &fields_ids_map))
            .map(|r| r.map_err(anyhow::Error::from))
            .collect()
    }

    fn search_documents(
        index: &Index,
        query: Option<String>,
        limit: Option<u32>,
        offset: Option<u32>,
        sort_criteria: Option<Vec<SortBy>>,
        filter: Option<Filter>,
        matching_strategy: Option<TermsMatchingStrategy>,
    ) -> Result<Vec<Document>> {
        // Create the search
        let rtxn = index.read_txn()?;
        let mut search = Search::new(&rtxn, index);

        // Configure the search based on given parameters
        search.limit(limit.unwrap_or(u32::MAX).try_into()?);
        if let Some(offset) = offset {
            search.offset(offset.try_into()?);
        }
        if let Some(query) = query {
            search.query(query);
        }
        if let Some(ref filter) = filter {
            let filter: milli::FilterCondition = filter.into();
            search.filter(filter.into());
        }
        if let Some(strat) = matching_strategy {
            search.terms_matching_strategy(strat.into());
        }
        if let Some(criteria) = sort_criteria {
            let criteria = criteria
                .iter()
                .map(|criterion| match criterion {
                    SortBy::Asc(field) => AscDesc::Asc(Member::Field(field.clone())),
                    SortBy::Desc(field) => AscDesc::Desc(Member::Field(field.clone())),
                })
                .collect();
            search.sort_criteria(criteria);
        }

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

    fn number_of_documents(index: &Index) -> Result<u64> {
        let rtxn = index.read_txn()?;
        index
            .number_of_documents(&rtxn)
            .map_err(anyhow::Error::from)
    }

    fn get_settings(index: &Index) -> Result<MimirIndexSettings> {
        let rtxn = index.read_txn()?;
        Ok(MimirIndexSettings {
            primary_key: index.primary_key(&rtxn)?.map(Into::into),
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

    fn set_settings(index: &Index, settings: MimirIndexSettings) -> Result<()> {
        // Destructure the settings into the corresponding fields
        let MimirIndexSettings {
            primary_key,
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
        let mut builder = update::Settings::new(&mut wtxn, index, &indexer_config);

        // Copy over the given settings
        match primary_key {
            Some(pkey) => builder.set_primary_key(pkey),
            None => builder.reset_primary_key(),
        }
        match searchable_fields {
            Some(fields) => builder.set_searchable_fields(fields),
            None => builder.reset_searchable_fields(),
        }
        builder.set_filterable_fields(filterable_fields.into_iter().collect());
        builder.set_sortable_fields(sortable_fields.into_iter().collect());
        builder.set_criteria(
            ranking_rules
                .iter()
                .map(String::as_str)
                .map(milli::Criterion::from_str)
                .map(|r| r.map_err(anyhow::Error::from))
                .collect::<Result<_>>()?,
        );
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

    fn create_dump(dir: &Path) -> Result<Dump> {
        let index = Self::create_index(dir)?;

        let dump = (|| {
            let settings = Self::get_settings(&index)?;
            let documents = Self::get_all_documents(&index)?;
            Ok((settings, documents))
        })();

        index.prepare_for_closing().wait();
        dump
    }

    fn import_dump(dir: &Path, dump: Dump) -> Result<()> {
        let (settings, documents) = dump;
        let index = Self::create_index(dir)?;

        let import_status = (|| {
            Self::set_settings(&index, settings)?;
            Self::set_documents(&index, documents)?;
            Ok(())
        })();

        index.prepare_for_closing().wait();
        import_status
    }
}

impl From<TermsMatchingStrategy> for milli::TermsMatchingStrategy {
    fn from(strat: TermsMatchingStrategy) -> Self {
        match strat {
            TermsMatchingStrategy::Last => milli::TermsMatchingStrategy::Last,
            TermsMatchingStrategy::All => milli::TermsMatchingStrategy::All,
        }
    }
}

fn create_condition<'a>(s: &'a str, cond: milli::Condition<'a>) -> milli::FilterCondition<'a> {
    milli::FilterCondition::Condition {
        fid: s.into(),
        op: cond,
    }
}

impl<'a> From<&'a Filter> for milli::FilterCondition<'a> {
    fn from(f: &'a Filter) -> Self {
        match f {
            Filter::Or(filters) => {
                milli::FilterCondition::Or(filters.iter().map(Self::from).collect())
            }
            Filter::And(filters) => {
                milli::FilterCondition::And(filters.iter().map(Self::from).collect())
            }
            Filter::Not(filter) => {
                milli::FilterCondition::Not(Box::new(Self::from(filter.as_ref())))
            }
            Filter::InValues { field, values } => milli::FilterCondition::In {
                fid: field.as_str().into(),
                els: values.iter().map(String::as_str).map(Into::into).collect(),
            },
            Filter::GreaterThan { field, value } => create_condition(
                field.as_str(),
                milli::Condition::GreaterThan(value.as_str().into()),
            ),
            Filter::GreaterThanOrEqual { field, value } => create_condition(
                field.as_str(),
                milli::Condition::GreaterThanOrEqual(value.as_str().into()),
            ),
            Filter::Equal { field, value } => create_condition(
                field.as_str(),
                milli::Condition::Equal(value.as_str().into()),
            ),
            Filter::NotEqual { field, value } => create_condition(
                field.as_str(),
                milli::Condition::NotEqual(value.as_str().into()),
            ),
            Filter::LessThan { field, value } => create_condition(
                field.as_str(),
                milli::Condition::LowerThan(value.as_str().into()),
            ),
            Filter::LessThanOrEqual { field, value } => create_condition(
                field.as_str(),
                milli::Condition::LowerThanOrEqual(value.as_str().into()),
            ),
            Filter::Between { field, from, to } => create_condition(
                field.as_str(),
                milli::Condition::Between {
                    from: from.as_str().into(),
                    to: to.as_str().into(),
                },
            ),
            Filter::Exists { field } => create_condition(field.as_str(), milli::Condition::Exists),
            Filter::IsNull { field } => create_condition(field.as_str(), milli::Condition::Null),
            Filter::IsEmpty { field } => create_condition(field.as_str(), milli::Condition::Empty),
        }
    }
}
