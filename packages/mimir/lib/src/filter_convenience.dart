import 'package:mimir/mimir.dart';

/// Extensions on [String] to more easily create [Field]s
extension StringToField on String {
  /// Creates a [Field] with a name equal to that of this string
  Field get field => Field(this);

  /// Creates a [Field] with a name equal to that of this string
  Field get f => field;
}

/// Represents a [Function] that builds a [Filter]
// The [to] argument is needed for the between method, unfortunately
typedef FilterBuilder = Filter Function(dynamic value, [dynamic to]);

class Field {
  /// The name of this field in documents to filter
  final String name;

  /// Constructs a [Field] with the given document field [name]
  const Field(this.name);

  /// Creates a [Filter] that specifies this [Field]
  /// is equal to the given [value].
  Filter isEqualTo(String value) => Filter.equal(field: name, value: value);

  /// Creates a [Filter] that specifies this [Field]
  /// is not equal to the given [value].
  Filter isNotEqualTo(String value) =>
      Filter.notEqual(field: name, value: value);

  /// Creates a [Filter] that specifies this [Field]
  /// is greater than or equal to the given [value].
  Filter isGreaterThanOrEqualTo(String value) =>
      Filter.greaterThanOrEqual(field: name, value: value);

  /// Creates a [Filter] that specifies this [Field]
  /// is less than or equal to the given [value].
  Filter isLessThanOrEqualTo(String value) =>
      Filter.lessThanOrEqual(field: name, value: value);

  /// Creates a [Filter] that specifies this [Field]
  /// is greater than the given [value].
  Filter isGreaterThan(String value) =>
      Filter.greaterThan(field: name, value: value);

  /// Creates a [Filter] that specifies this [Field]
  /// is less than the given [value].
  Filter isLessThan(String value) => Filter.lessThan(field: name, value: value);

  /// Creates a [Filter] that specifies this [Field]
  /// has at least one of the given [values].
  ///
  /// Example:
  /// ```dart
  /// Field('colors').has(['red', 'blue'])
  /// ```
  /// Would create a [Filter] that looks for documents with a colors field
  /// that contains at least one of 'red' or 'blue'.
  Filter has(List<String> values) =>
      Filter.inValues(field: name, values: values);

  /// Creates a [Filter] that specifies this [Field]
  /// is between the two given values ([from] and [to]).
  Filter isBetween(String from, String to) =>
      Filter.between(field: name, from: from, to: to);

  /// Creates a [Filter] in a more concise way.
  ///
  /// Instead of:
  /// ```dart
  /// Field('id').isEqualTo('1234')
  /// ```
  /// You can do:
  /// ```dart
  /// Field('id')['==']('1234')
  /// ```
  FilterBuilder operator [](String op) {
    switch (op) {
      case '==':
        return isEqualTo as FilterBuilder;
      case '!=':
        return isNotEqualTo as FilterBuilder;
      case '>=':
        return isGreaterThanOrEqualTo as FilterBuilder;
      case '<=':
        return isLessThanOrEqualTo as FilterBuilder;
      case '>':
        return isGreaterThan as FilterBuilder;
      case '<':
        return isLessThan as FilterBuilder;
      case 'in':
      case 'IN':
      case 'has':
      case 'HAS':
        return has as FilterBuilder;
      case 'between':
      case 'BETWEEN':
      case 'isBetween':
      case 'IS_BETWEEN':
        return isBetween as FilterBuilder;
      default:
        throw UnsupportedError('Operator "$op" is invalid!');
    }
  }
}
