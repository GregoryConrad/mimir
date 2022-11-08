use std::{
    collections::HashMap,
    convert::TryInto,
    fs::create_dir_all,
    io::Cursor,
    path::Path,
    sync::{Mutex, RwLock},
};

use anyhow::Result;
use flutter_rust_bridge::frb;
use lazy_static::lazy_static;
use milli::{
    documents::{DocumentsBatchBuilder, DocumentsBatchReader},
    heed::EnvOpenOptions,
    update, AscDesc, Criterion, Index, Member, Search, SearchResult,
};

lazy_static! {
    /// The mapping of instance paths (directories) to instances.
    static ref INSTANCES: RwLock<HashMap<String, Instance>> = RwLock::new(HashMap::new());
}

struct Instance {
    indexes: RwLock<HashMap<String, Mutex<Index>>>,
}

/// Ensures an instance of milli (represented by just a directory) is initialized.
pub fn ensure_instance_initialized(instance_dir: String) -> Result<()> {
    let instances = INSTANCES.read().unwrap();

    // If this instance does not yet exist, create it
    if !instances.contains_key(&instance_dir) {
        drop(instances); // prevent deadlock with the prev read lock and now write lock
        let mut instances = INSTANCES.write().unwrap();

        // Perhaps the instance was initialized while we were waiting to get the lock
        // Now that we have the write lock, check that we actually need to do anything
        if !instances.contains_key(&instance_dir) {
            create_dir_all(&instance_dir)?;
            let new_instance = Instance {
                indexes: RwLock::new(HashMap::new()),
            };
            instances.insert(instance_dir.clone(), new_instance);
        }
    }

    Ok(())
}

/// Ensures a milli index is initialized.
pub fn ensure_index_initialized(instance_dir: String, index_name: String) -> Result<()> {
    ensure_instance_initialized(instance_dir.clone())?;
    let instances = INSTANCES.read().unwrap();
    let instance = instances.get(&instance_dir).unwrap();
    let indexes = instance.indexes.read().unwrap();

    // If this index does not yet exist, create it
    if !indexes.contains_key(&index_name) {
        drop(indexes); // prevent deadlock with the prev read lock and now write lock
        let mut indexes = instance.indexes.write().unwrap();

        // Perhaps the index was initialized while we were waiting to get the lock
        // Now that we have the write lock, check that we actually need to do anything
        if !indexes.contains_key(&index_name) {
            let path = Path::new(&instance_dir).join(&index_name);
            create_dir_all(&path)?;
            let options = EnvOpenOptions::new();
            let index = Index::new(options, &path).unwrap();
            indexes.insert(index_name.clone(), Mutex::new(index));
        }
    }

    Ok(())
}

macro_rules! get_instances {
    () => {
        INSTANCES.read().unwrap()
    };
}

macro_rules! get_indexes {
    ($instances:ident, $instance_dir:ident) => {
        $instances
            .get(&$instance_dir)
            .unwrap()
            .indexes
            .read()
            .unwrap()
    };
}

macro_rules! get_index {
    ($instance:ident, $index_name:ident) => {
        $instance.get(&$index_name).unwrap().lock().unwrap()
    };
}

/// Adds the given list of documents to the specified milli index.
/// Replaces documents that already exist in the index based on document ids.
pub fn add_documents(
    instance_dir: String,
    index_name: String,
    json_documents: Vec<String>,
) -> Result<()> {
    ensure_index_initialized(instance_dir.clone(), index_name.clone())?;
    let instances = get_instances!();
    let indexes = get_indexes!(instances, instance_dir);
    let index = get_index!(indexes, index_name);

    // Create a batch builder to convert json_documents into milli's format
    let mut builder = DocumentsBatchBuilder::new(Vec::new());
    for doc in json_documents.iter() {
        let doc: serde_json::Value = serde_json::from_str(&doc)?;
        let doc = doc
            .as_object()
            .ok_or(anyhow::Error::msg(
                "A json document was not Map<String, dynamic>",
            ))?
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

/// Deletes the documents with the given ids from the milli index.
pub fn delete_documents(
    instance_dir: String,
    index_name: String,
    document_ids: Vec<String>,
) -> Result<()> {
    ensure_index_initialized(instance_dir.clone(), index_name.clone())?;
    let instances = get_instances!();
    let indexes = get_indexes!(instances, instance_dir);
    let index = get_index!(indexes, index_name);

    todo!()
}

/// Replaces all documents in the index with the given documents
pub fn set_documents(
    instance_dir: String,
    index_name: String,
    json_documents: Vec<String>,
) -> Result<()> {
    ensure_index_initialized(instance_dir.clone(), index_name.clone())?;
    let instances = get_instances!();
    let indexes = get_indexes!(instances, instance_dir);
    let index = get_index!(indexes, index_name);

    todo!()
}

/// Returns the document with the specified id from the index, if one exists
pub fn get_document(
    instance_dir: String,
    index_name: String,
    document_id: String,
) -> Result<Option<String>> {
    ensure_index_initialized(instance_dir.clone(), index_name.clone())?;
    let instances = get_instances!();
    let indexes = get_indexes!(instances, instance_dir);
    let index = get_index!(indexes, index_name);

    todo!()
}

/// Returns all documents stored in the index.
pub fn get_documents(instance_dir: String, index_name: String) -> Result<Vec<String>> {
    ensure_index_initialized(instance_dir.clone(), index_name.clone())?;
    let instances = get_instances!();
    let indexes = get_indexes!(instances, instance_dir);
    let index = get_index!(indexes, index_name);

    todo!()
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

/// Whether to sort a field in ascending or descending order
/// See https://docs.meilisearch.com/reference/api/search.html#sort
pub enum SortAscDesc {
    Asc(String),
    Desc(String),
}

/// Performs a search against the index and returns the documents found
pub fn search_documents(
    instance_dir: String,
    index_name: String,
    query: Option<String>,
    limit: Option<u32>,
    // Uncomment the following line once the following is resolved:
    // https://github.com/fzyzcjy/flutter_rust_bridge/issues/828
    // matching_strategy: Option<TermsMatchingStrategy>,
    matching_strategy: TermsMatchingStrategy,
    sort_criteria: Option<Vec<SortAscDesc>>,
) -> Result<Vec<String>> {
    // Delete the following line once the following is resolved:
    // https://github.com/fzyzcjy/flutter_rust_bridge/issues/828
    let matching_strategy = Some(matching_strategy);

    ensure_index_initialized(instance_dir.clone(), index_name.clone())?;
    let instances = get_instances!();
    let indexes = get_indexes!(instances, instance_dir);
    let index = get_index!(indexes, index_name);

    // Create the search
    let rtxn = index.read_txn()?;
    let mut search = Search::new(&rtxn, &index);

    // Configure the search based on given parameters
    query.map(|q| search.query(q));
    limit.map(|l| search.limit(l.try_into().unwrap()));
    matching_strategy.map(|s| search.terms_matching_strategy(s));
    sort_criteria.map(|criteria| {
        let criteria = criteria
            .iter()
            .map(|criterion| match criterion {
                SortAscDesc::Asc(field) => AscDesc::Asc(Member::Field(field.clone())),
                SortAscDesc::Desc(field) => AscDesc::Desc(Member::Field(field.clone())),
            })
            .collect();
        search.sort_criteria(criteria)
    });

    // Get the documents based on the search results
    let SearchResult { documents_ids, .. } = search.execute()?;
    let field_ids_map = index.fields_ids_map(&rtxn)?;
    let mut documents = Vec::new();
    for (_id, obkv) in index.documents(&rtxn, documents_ids)? {
        let mut document = serde_json::Map::new();
        for (key, value) in obkv.iter() {
            let value = serde_json::from_slice(value)?;
            let key = field_ids_map
                .name(key)
                .expect("Missing field name")
                .to_string();
            document.insert(key, value);
        }
        let document = serde_json::to_string(&document)?;
        documents.push(document);
    }
    Ok(documents)
}

/// Represents the synonyms of a given word
pub struct Synonyms {
    pub word: String,
    pub synonyms: Vec<String>,
}

/// Represents the typo tolerance settings of an index
pub struct TypoTolerance {
    pub enabled: bool,
    pub min_word_size_for_one_typo: u8,
    pub min_word_size_for_two_typos: u8,
    pub disable_on_words: Vec<String>,
    pub disable_on_fields: Vec<String>,
}

/// The settings of a milli index
// This is created as an enum so we get freezed support.
// Regular created classes do not have equals, copyWith, etc.
pub enum MeiliIndexSettings {
    /// The settings of a milli index.
    // Name is "Raw" so we get MeiliIndexSettings.raw constructor in Dart
    Raw {
        searchable_fields: Option<Vec<String>>,
        filterable_fields: Vec<String>,
        sortable_fields: Vec<String>,
        ranking_rules: Vec<String>,
        stop_words: Vec<String>,
        synonyms: Vec<Synonyms>,
        typo_tolerance: TypoTolerance,
    },
}

/// Gets the settings of the specified index
pub fn get_settings(instance_dir: String, index_name: String) -> Result<MeiliIndexSettings> {
    ensure_index_initialized(instance_dir.clone(), index_name.clone())?;
    let instances = get_instances!();
    let indexes = get_indexes!(instances, instance_dir);
    let index = get_index!(indexes, index_name);

    let rtxn = index.read_txn()?;
    Ok(MeiliIndexSettings::Raw {
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
            .map(|(word, synonyms)| (word[0].clone(), synonyms[0].clone()))
            .map(|(word, synonyms)| Synonyms { word, synonyms })
            .collect(),
        typo_tolerance: TypoTolerance {
            enabled: index.authorize_typos(&rtxn)?,
            min_word_size_for_one_typo: index.min_word_len_one_typo(&rtxn)?,
            min_word_size_for_two_typos: index.min_word_len_two_typos(&rtxn)?,
            disable_on_words: index
                .exact_words(&rtxn)?
                .map(|words| words.stream().into_strs())
                .unwrap_or_else(|| Ok(Vec::new()))?,
            disable_on_fields: index
                .exact_attributes(&rtxn)?
                .into_iter()
                .map(String::from)
                .collect(),
        },
    })
}

/// Sets the settings of the specified index
pub fn set_settings(
    instance_dir: String,
    index_name: String,
    settings: MeiliIndexSettings,
) -> Result<()> {
    ensure_index_initialized(instance_dir.clone(), index_name.clone())?;
    let instances = get_instances!();
    let indexes = get_indexes!(instances, instance_dir);
    let index = get_index!(indexes, index_name);

    // Destructure the settings into the corresponding fields
    let (
        searchable_fields,
        filterable_fields,
        sortable_fields,
        ranking_rules,
        stop_words,
        synonyms,
        typo_tolerance,
    ) = match settings {
        MeiliIndexSettings::Raw {
            searchable_fields,
            filterable_fields,
            sortable_fields,
            ranking_rules,
            stop_words,
            synonyms,
            typo_tolerance,
        } => (
            searchable_fields,
            filterable_fields,
            sortable_fields,
            ranking_rules,
            stop_words,
            synonyms,
            typo_tolerance,
        ),
    };

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
    builder.set_autorize_typos(typo_tolerance.enabled);
    builder.set_min_word_len_one_typo(typo_tolerance.min_word_size_for_one_typo);
    builder.set_min_word_len_two_typos(typo_tolerance.min_word_size_for_two_typos);
    builder.set_exact_words(typo_tolerance.disable_on_words.into_iter().collect());
    builder.set_exact_attributes(typo_tolerance.disable_on_fields.into_iter().collect());

    // Execute the settings update
    builder.execute(|_| {}, || false)?;
    wtxn.commit()?;

    Ok(())
}
