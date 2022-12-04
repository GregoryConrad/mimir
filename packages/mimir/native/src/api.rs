use anyhow::Result;
use flutter_rust_bridge::frb;

use crate::embedded_milli::{self, Document};

/// Enforce the binding for this library (to prevent tree-shaking)
#[no_mangle]
pub extern "C" fn enforce_binding() {}

/// See https://docs.meilisearch.com/reference/api/search.html#matching-strategy
pub enum TermsMatchingStrategy {
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
    /// Sort by the given field in ascending order
    Asc(String),
    /// Sort by the given field in descending order
    Desc(String),
}

/// The filters to be used in a search/query
pub enum Filter {
    /// Creates an "or" [Filter] of the given sub-filters.
    Or(Vec<Filter>),
    /// Creates an "and" [Filter] of the given sub-filters.
    And(Vec<Filter>),
    /// Creates a "not" [Filter] of the given sub-filter.
    Not(Box<Filter>),

    /// Creates a [Filter] that specifies the given field exists.
    Exists { field: String },
    /// Creates a [Filter] for the "IN" operator.
    InValues { field: String, values: Vec<String> },
    /// Creates a [Filter] for the ">" operator.
    GreaterThan { field: String, value: String },
    /// Creates a [Filter] for the ">=" operator.
    GreaterThanOrEqual { field: String, value: String },
    /// Creates a [Filter] for the "==" operator.
    Equal { field: String, value: String },
    /// Creates a [Filter] for the "!=" operator.
    NotEqual { field: String, value: String },
    /// Creates a [Filter] for the "<" operator.
    LessThan { field: String, value: String },
    /// Creates a [Filter] for the "<=" operator.
    LessThanOrEqual { field: String, value: String },
    /// Creates a [Filter] for the "BETWEEN" operator.
    Between {
        field: String,
        from: String,
        to: String,
    },
}

/// Represents the synonyms of a given word
#[derive(Clone, Debug, Eq, PartialEq)]
#[frb(dart_metadata=("freezed"))]
pub struct Synonyms {
    pub word: String,
    pub synonyms: Vec<String>,
}

/// The settings of a mimir index
#[derive(Clone, Debug, Eq, PartialEq)]
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

/// Ensures an instance of milli (represented by just a directory) is initialized
pub fn ensure_instance_initialized(instace_dir: String) -> Result<()> {
    embedded_milli::ensure_instance_initialized(instace_dir.as_str())
}

/// Ensures a milli index is initialized
pub fn ensure_index_initialized(instance_dir: String, index_name: String) -> Result<()> {
    embedded_milli::ensure_index_initialized(instance_dir.as_str(), index_name.as_str())
}

/// Adds the given list of documents to the specified milli index
///
/// Replaces documents that already exist in the index based on document ids.
pub fn add_documents(
    instance_dir: String,
    index_name: String,
    documents: Vec<String>,
) -> Result<()> {
    let documents = documents
        .iter()
        .map(StringExt::to_document)
        .collect::<Result<_>>()?;
    embedded_milli::add_documents(instance_dir.as_str(), index_name.as_str(), documents)
}

/// Deletes the documents with the given ids from the milli index
pub fn delete_documents(
    instance_dir: String,
    index_name: String,
    document_ids: Vec<String>,
) -> Result<()> {
    embedded_milli::delete_documents(instance_dir.as_str(), index_name.as_str(), document_ids)
}

/// Deletes all the documents from the milli index
pub fn delete_all_documents(instance_dir: String, index_name: String) -> Result<()> {
    embedded_milli::delete_all_documents(instance_dir.as_str(), index_name.as_str())
}

/// Replaces all documents with the given documents
pub fn set_documents(
    instance_dir: String,
    index_name: String,
    documents: Vec<String>,
) -> Result<()> {
    let documents = documents
        .iter()
        .map(StringExt::to_document)
        .collect::<Result<_>>()?;
    embedded_milli::set_documents(instance_dir.as_str(), index_name.as_str(), documents)
}

/// Returns the document with the specified id from the index, if one exists
pub fn get_document(
    instance_dir: String,
    index_name: String,
    document_id: String,
) -> Result<Option<String>> {
    embedded_milli::get_document(instance_dir.as_str(), index_name.as_str(), document_id)?
        .as_ref()
        .map(DocumentExt::to_string)
        .transpose()
}

/// Returns all documents stored in the index.
pub fn get_all_documents(instance_dir: String, index_name: String) -> Result<Vec<String>> {
    embedded_milli::get_all_documents(instance_dir.as_str(), index_name.as_str())?
        .iter()
        .map(DocumentExt::to_string)
        .collect()
}

/// Performs a search against the index and returns the documents found
pub fn search_documents(
    instance_dir: String,
    index_name: String,
    query: Option<String>,
    limit: Option<u32>,
    sort_criteria: Option<Vec<SortBy>>,
    // TODO make these following two optional!
    //  https://github.com/GregoryConrad/mimir/issues/77
    filter: Filter,
    matching_strategy: TermsMatchingStrategy,
) -> Result<Vec<String>> {
    embedded_milli::search_documents(
        instance_dir.as_str(),
        index_name.as_str(),
        query,
        limit,
        sort_criteria,
        Some(filter)
            // TODO Remove the following and_then when filter is a true Option
            .and_then(|f| match f {
                Filter::Or(x) if x.is_empty() => None,
                f => Some(f),
            }),
        Some(matching_strategy),
    )?
    .iter()
    .map(DocumentExt::to_string)
    .collect()
}

/// Gets the settings of the specified index
pub fn get_settings(instance_dir: String, index_name: String) -> Result<MimirIndexSettings> {
    embedded_milli::get_settings(instance_dir.as_str(), index_name.as_str())
}

/// Sets the settings of the specified index
pub fn set_settings(
    instance_dir: String,
    index_name: String,
    settings: MimirIndexSettings,
) -> Result<()> {
    embedded_milli::set_settings(instance_dir.as_str(), index_name.as_str(), settings)
}

trait StringExt {
    fn to_document(&self) -> Result<Document>;
}

impl StringExt for String {
    fn to_document(&self) -> Result<Document> {
        serde_json::from_str(self).map_err(anyhow::Error::from)
    }
}

trait DocumentExt {
    fn to_string(&self) -> Result<String>;
}

impl DocumentExt for Document {
    fn to_string(&self) -> Result<String> {
        serde_json::to_string(self).map_err(anyhow::Error::from)
    }
}
