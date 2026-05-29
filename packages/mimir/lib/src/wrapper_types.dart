/// Whether to sort by a field in ascending or descending order.
/// See https://docs.meilisearch.com/reference/api/search.html#sort
sealed class SortBy {
  /// Sort by the given field in ascending order
  const factory SortBy.asc(String field) = SortByAsc.new;

  /// Sort by the given field in descending order
  const factory SortBy.desc(String field) = SortByDesc.new;
}

/// Sort by [field] in ascending order.
final class SortByAsc implements SortBy {
  /// Creates a [SortByAsc] that sorts by [field].
  const SortByAsc(this.field);

  /// The field to sort in ascending order.
  final String field;
}

/// Sort by [field] in descending order.
final class SortByDesc implements SortBy {
  /// Creates a [SortByDesc] that sorts by [field].
  const SortByDesc(this.field);

  /// The field to sort in descending order.
  final String field;
}

/// See https://docs.meilisearch.com/reference/api/search.html#matching-strategy
enum TermsMatchingStrategy {
  /// Remove last word first
  last,

  /// All words are mandatory
  all,
}

/// Represents the synonyms of a word.
typedef Synonyms = ({String word, List<String> synonyms});
