use std::{collections::HashMap, convert::TryInto, fs::create_dir_all, io::Cursor, path::Path};

use anyhow::{anyhow, Result};
use flutter_rust_bridge::frb;
use lazy_static::lazy_static;
use milli::{
    documents::{DocumentsBatchBuilder, DocumentsBatchReader},
    heed::EnvOpenOptions,
    update, AscDesc, Criterion, Index, Member, Search, SearchResult,
};
use parking_lot::{Mutex, RwLock};

/// Enforce the binding for this library (to prevent tree-shaking)
#[no_mangle]
pub extern "C" fn enforce_binding() {}

lazy_static! {
    /// The mapping of instance paths (directories) to instances
    static ref INSTANCES: RwLock<HashMap<String, Instance>> = RwLock::new(HashMap::new());
}

// This is 2^30, so it will be a multiple of whatever the system page size is
const MAX_MAP_SIZE: usize = 1_073_741_824;

struct Instance {
    indexes: RwLock<HashMap<String, Mutex<Index>>>,
}

/// Ensures an instance of milli (represented by just a directory) is initialized
fn ensure_instance_initialized(instance_dir: &String) -> Result<()> {
    let instances = INSTANCES.read();

    // If this instance does not yet exist, create it
    if !instances.contains_key(instance_dir) {
        drop(instances); // prevent deadlock with the prev read lock and now write lock
        let mut instances = INSTANCES.write();

        // Perhaps the instance was initialized while we were waiting to get the lock
        // Now that we have the write lock, check that we actually need to do anything
        if !instances.contains_key(instance_dir) {
            create_dir_all(instance_dir)?;
            let new_instance = Instance {
                indexes: RwLock::new(HashMap::new()),
            };
            instances.insert(instance_dir.clone(), new_instance);
        }
    }

    Ok(())
}

/// Ensures a milli index is initialized
fn ensure_index_initialized(instance_dir: &String, index_name: &String) -> Result<()> {
    ensure_instance_initialized(instance_dir)?;
    let instances = INSTANCES.read();
    let instance = instances.get(instance_dir).unwrap();
    let indexes = instance.indexes.read();

    // If this index does not yet exist, create it
    if !indexes.contains_key(index_name) {
        drop(indexes); // prevent deadlock with the prev read lock and now write lock
        let mut indexes = instance.indexes.write();

        // Perhaps the index was initialized while we were waiting to get the lock
        // Now that we have the write lock, check that we actually need to do anything
        if !indexes.contains_key(index_name) {
            let path = Path::new(instance_dir).join(index_name);
            create_dir_all(&path)?;
            let mut options = EnvOpenOptions::new();
            options.map_size(MAX_MAP_SIZE);
            let index = Index::new(options, &path).unwrap();
            indexes.insert(index_name.clone(), Mutex::new(index));
        }
    }

    Ok(())
}

macro_rules! get_instances {
    () => {
        INSTANCES.read()
    };
}

macro_rules! get_indexes {
    ($instances:ident, $instance_dir:ident) => {
        $instances.get(&$instance_dir).unwrap().indexes.read()
    };
}

macro_rules! get_index {
    ($instance:ident, $index_name:ident) => {
        $instance.get(&$index_name).unwrap().lock()
    };
}

// We need this because there is not variant of obkv_to_json that uses all fields in obkv
macro_rules! milli_doc_to_json_string {
    ($document:ident, $fields_ids_map:ident) => {{
        let obj = milli::obkv_to_json(
            $document
                .iter()
                .map(|(k, _v)| k)
                .collect::<Vec<_>>()
                .as_slice(),
            &$fields_ids_map,
            $document.clone(),
        )?;
        serde_json::to_string(&obj).map_err(anyhow::Error::from)
    }};
}

/// Adds the given list of documents to the specified milli index
///
/// Replaces documents that already exist in the index based on document ids.
pub fn add_documents(
    instance_dir: String,
    index_name: String,
    json_documents: Vec<String>,
) -> Result<()> {
    ensure_index_initialized(&instance_dir, &index_name)?;
    let instances = get_instances!();
    let indexes = get_indexes!(instances, instance_dir);
    let index = get_index!(indexes, index_name);

    // Create a batch builder to convert json_documents into milli's format
    let mut builder = DocumentsBatchBuilder::new(Vec::new());
    for doc in json_documents {
        let doc: serde_json::Value = serde_json::from_str(&doc)?;
        let doc = doc
            .as_object()
            .ok_or(anyhow!("A json document was not Map<String, dynamic>"))?
            .clone();
        builder.append_json_object(&doc)?;
    }

    // Flush the contents of the builder and retreive the buffer to make a batch reader
    let buff = builder.into_inner()?;
    let reader = DocumentsBatchReader::from_reader(Cursor::new(buff))?;

    // Create the configs needed for the batch document addition
    let indexer_config = update::IndexerConfig::default();
    let indexing_config = update::IndexDocumentsConfig {
        update_method: update::IndexDocumentsMethod::ReplaceDocuments,
        autogenerate_docids: true,
        ..Default::default()
    };

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
    wtxn.commit()?;

    Ok(())
}

/// Deletes the documents with the given ids from the milli index
pub fn delete_documents(
    instance_dir: String,
    index_name: String,
    document_ids: Vec<String>,
) -> Result<()> {
    ensure_index_initialized(&instance_dir, &index_name)?;
    let instances = get_instances!();
    let indexes = get_indexes!(instances, instance_dir);
    let index = get_index!(indexes, index_name);

    let mut wtxn = index.write_txn()?;
    let mut builder = update::DeleteDocuments::new(&mut wtxn, &index)?;
    for doc_id in document_ids {
        builder.delete_external_id(&doc_id);
    }
    builder.execute()?;
    wtxn.commit()?;

    Ok(())
}

/// Deletes all the documents from the milli index
pub fn delete_all_documents(instance_dir: String, index_name: String) -> Result<()> {
    ensure_index_initialized(&instance_dir, &index_name)?;
    let instances = get_instances!();
    let indexes = get_indexes!(instances, instance_dir);
    let index = get_index!(indexes, index_name);

    let mut wtxn = index.write_txn()?;
    let builder = update::ClearDocuments::new(&mut wtxn, &index);
    builder.execute()?;
    wtxn.commit()?;

    Ok(())
}

/// Replaces all documents with the given documents
pub fn set_documents(
    instance_dir: String,
    index_name: String,
    json_documents: Vec<String>,
) -> Result<()> {
    // TODO combine into 1 write txn
    delete_all_documents(instance_dir.clone(), index_name.clone())?;
    add_documents(instance_dir, index_name, json_documents)
}

/// Returns the document with the specified id from the index, if one exists
pub fn get_document(
    instance_dir: String,
    index_name: String,
    document_id: String,
) -> Result<Option<String>> {
    ensure_index_initialized(&instance_dir, &index_name)?;
    let instances = get_instances!();
    let indexes = get_indexes!(instances, instance_dir);
    let index = get_index!(indexes, index_name);

    let rtxn = index.read_txn()?;
    let fields_ids_map = index.fields_ids_map(&rtxn)?;
    let external_ids = index.external_documents_ids(&rtxn)?;
    let internal_id = match external_ids.get(document_id) {
        Some(id) => id,
        None => return Ok(None),
    };
    let documents = index.documents(&rtxn, vec![internal_id])?;
    let (_id, document) = documents.first().ok_or(anyhow!("Missing document"))?;
    milli_doc_to_json_string!(document, fields_ids_map).map(|s| Some(s))
}

/// Returns all documents stored in the index.
pub fn get_all_documents(instance_dir: String, index_name: String) -> Result<Vec<String>> {
    ensure_index_initialized(&instance_dir, &index_name)?;
    let instances = get_instances!();
    let indexes = get_indexes!(instances, instance_dir);
    let index = get_index!(indexes, index_name);

    let rtxn = index.read_txn()?;
    let fields_ids_map = index.fields_ids_map(&rtxn)?;
    let documents = index.all_documents(&rtxn)?;
    documents
        .map(|result| {
            let (_id, document) = result?;
            milli_doc_to_json_string!(document, fields_ids_map)
        })
        .collect()
}

/// Re-export TermsMatchingStrategy from milli to use in search
pub use milli::TermsMatchingStrategy;

/// See https://docs.meilisearch.com/reference/api/search.html#matching-strategy
#[frb(mirror(TermsMatchingStrategy))]
pub enum _TermsMatchingStrategy {
    /// Remove last word first
    Last,
    /// Remove first word first
    First,
    /// Remove more frequent word first
    Frequency,
    /// Remove smallest word first
    Size,
    /// Only one of the word is mandatory
    Any,
    /// All words are mandatory
    All,
}

/// Whether to sort by a field in ascending or descending order
/// See https://docs.meilisearch.com/reference/api/search.html#sort
pub enum SortBy {
    Asc(String),
    Desc(String),
}

/// The filters to be used in a search/query
pub enum Filter {
    Or(Vec<Filter>),
    And(Vec<Filter>),
    Not(Box<Filter>),

    Exists {
        field: String,
    },
    InValues {
        field: String,
        values: Vec<String>,
    },
    GreaterThan {
        field: String,
        value: String,
    },
    GreaterThanOrEqual {
        field: String,
        value: String,
    },
    Equal {
        field: String,
        value: String,
    },
    NotEqual {
        field: String,
        value: String,
    },
    LessThan {
        field: String,
        value: String,
    },
    LessThanOrEqual {
        field: String,
        value: String,
    },
    Between {
        field: String,
        from: String,
        to: String,
    },
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
            milli::FilterCondition::Or(filters.into_iter().map(create_filter_condition).collect())
        }
        Filter::And(filters) => {
            milli::FilterCondition::And(filters.into_iter().map(create_filter_condition).collect())
        }
        Filter::Not(filter) => {
            milli::FilterCondition::Not(Box::new(create_filter_condition(filter)))
        }
        Filter::InValues { field, values } => milli::FilterCondition::In {
            fid: create_token(&field),
            els: values.iter().map(create_token).collect(),
        },
        Filter::Exists { field } => create_condition(&field, milli::Condition::Exists),
        Filter::GreaterThan { field, value } => {
            create_condition(&field, milli::Condition::GreaterThan(create_token(&value)))
        }
        Filter::GreaterThanOrEqual { field, value } => create_condition(
            &field,
            milli::Condition::GreaterThanOrEqual(create_token(&value)),
        ),
        Filter::Equal { field, value } => {
            create_condition(&field, milli::Condition::Equal(create_token(&value)))
        }
        Filter::NotEqual { field, value } => {
            create_condition(&field, milli::Condition::NotEqual(create_token(&value)))
        }
        Filter::LessThan { field, value } => {
            create_condition(&field, milli::Condition::LowerThan(create_token(&value)))
        }
        Filter::LessThanOrEqual { field, value } => create_condition(
            &field,
            milli::Condition::LowerThanOrEqual(create_token(&value)),
        ),
        Filter::Between { field, from, to } => create_condition(
            &field,
            milli::Condition::Between {
                from: create_token(&from),
                to: create_token(&to),
            },
        ),
    }
}

/// Performs a search against the index and returns the documents found
pub fn search_documents(
    instance_dir: String,
    index_name: String,
    query: Option<String>,
    limit: Option<u32>,
    sort_criteria: Option<Vec<SortBy>>,
    // Make the following two lines optional once the following is resolved:
    // https://github.com/fzyzcjy/flutter_rust_bridge/issues/828
    filter: Filter,
    matching_strategy: TermsMatchingStrategy,
) -> Result<Vec<String>> {
    ensure_index_initialized(&instance_dir, &index_name)?;
    let instances = get_instances!();
    let indexes = get_indexes!(instances, instance_dir);
    let index = get_index!(indexes, index_name);

    // Delete the following two lines once the following is resolved:
    // https://github.com/fzyzcjy/flutter_rust_bridge/issues/828
    let matching_strategy = Some(matching_strategy);
    let filter = Some(filter);

    // Create the search
    let rtxn = index.read_txn()?;
    let mut search = Search::new(&rtxn, &index);

    // Configure the search based on given parameters
    query.map(|q| search.query(q));
    search.limit(limit.unwrap_or(u32::MAX).try_into()?);
    matching_strategy.map(|s| search.terms_matching_strategy(s));
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
        // TODO Remove the following map_or when filter is a true Option
        .map_or(None, |f| match f {
            Filter::Or(x) if x.is_empty() => None,
            f => Some(f),
        })
        .map(create_filter_condition)
        .map(|f| search.filter(f.into()));

    // Get the documents based on the search results
    let SearchResult { documents_ids, .. } = search.execute()?;
    let fields_ids_map = index.fields_ids_map(&rtxn)?;
    index
        .documents(&rtxn, documents_ids)?
        .iter()
        .map(|(_id, document)| milli_doc_to_json_string!(document, fields_ids_map))
        .collect()
}

/// Represents the synonyms of a given word
#[frb(dart_metadata=("freezed"))]
pub struct Synonyms {
    pub word: String,
    pub synonyms: Vec<String>,
}

/// The settings of a milli index
#[frb(dart_metadata=("freezed"))]
pub struct MimirIndexSettings {
    pub searchable_fields: Option<Vec<String>>,
    pub filterable_fields: Vec<String>,
    pub sortable_fields: Vec<String>,
    pub ranking_rules: Vec<String>,
    pub stop_words: Vec<String>,
    pub synonyms: Vec<Synonyms>,
    pub typos_enabled: bool,
    pub min_word_size_for_one_typo: u8,
    pub min_word_size_for_two_typos: u8,
    pub disallow_typos_on_words: Vec<String>,
    pub disallow_typos_on_fields: Vec<String>,
}

/// Gets the settings of the specified index
pub fn get_settings(instance_dir: String, index_name: String) -> Result<MimirIndexSettings> {
    ensure_index_initialized(&instance_dir, &index_name)?;
    let instances = get_instances!();
    let indexes = get_indexes!(instances, instance_dir);
    let index = get_index!(indexes, index_name);

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

/// Sets the settings of the specified index
pub fn set_settings(
    instance_dir: String,
    index_name: String,
    settings: MimirIndexSettings,
) -> Result<()> {
    ensure_index_initialized(&instance_dir, &index_name)?;
    let instances = get_instances!();
    let indexes = get_indexes!(instances, instance_dir);
    let index = get_index!(indexes, index_name);

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
    wtxn.commit()?;

    Ok(())
}
