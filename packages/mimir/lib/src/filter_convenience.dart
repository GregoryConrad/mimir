import 'package:mimir/mimir.dart';

extension StringToField on String {
  Field get field => Field(this);
  Field get f => field;
}

typedef FilterBuilder = Filter Function(dynamic value, [dynamic to]);

class Field {
  final String name;

  const Field(this.name);

  Filter isEqualTo(String value) => Filter.equal(field: name, value: value);
  Filter isNotEqualTo(String value) =>
      Filter.notEqual(field: name, value: value);
  Filter isGreaterThanOrEqualTo(String value) =>
      Filter.greaterThanOrEqual(field: name, value: value);
  Filter isLessThanOrEqualTo(String value) =>
      Filter.lessThanOrEqual(field: name, value: value);
  Filter isGreaterThan(String value) =>
      Filter.greaterThan(field: name, value: value);
  Filter isLessThan(String value) => Filter.lessThan(field: name, value: value);
  Filter has(List<String> values) =>
      Filter.inValues(field: name, values: values);
  Filter isBetween(String from, String to) =>
      Filter.between(field: name, from: from, to: to);

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
        throw UnsupportedError('Operator "$op" is not valid!');
    }
  }
}
