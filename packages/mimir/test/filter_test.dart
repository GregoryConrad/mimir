import 'package:mimir/mimir.dart';
import 'package:test/test.dart';

void main() {
  test('Filter convenience produces correct filters', () {
    final and = Mimir.and;
    final or = Mimir.or;
    final not = Mimir.not;
    final where = Mimir.where;

    expect(
      where('f', isEqualTo: 'abc'),
      const Filter.equal(field: 'f', value: 'abc'),
    );
    expect(
      where('f', isNotEqualTo: 'abc'),
      const Filter.notEqual(field: 'f', value: 'abc'),
    );
    expect(
      where('f', isGreaterThanOrEqualTo: 'abc'),
      const Filter.greaterThanOrEqual(field: 'f', value: 'abc'),
    );
    expect(
      where('f', isLessThanOrEqualTo: 'abc'),
      const Filter.lessThanOrEqual(field: 'f', value: 'abc'),
    );
    expect(
      where('f', isGreaterThan: 'abc'),
      const Filter.greaterThan(field: 'f', value: 'abc'),
    );
    expect(
      where('f', isLessThan: 'abc'),
      const Filter.lessThan(field: 'f', value: 'abc'),
    );
    expect(
      where('f', exists: true),
      const Filter.exists(field: 'f'),
    );
    expect(
      where('f', exists: false),
      const Filter.not(Filter.exists(field: 'f')),
    );
    expect(
      where('f', isNull: true),
      const Filter.isNull(field: 'f'),
    );
    expect(
      where('f', isNull: false),
      const Filter.not(Filter.isNull(field: 'f')),
    );
    expect(
      where('f', isEmpty: true),
      const Filter.isEmpty(field: 'f'),
    );
    expect(
      where('f', isEmpty: false),
      const Filter.not(Filter.isEmpty(field: 'f')),
    );
    expect(
      where('f', containsAtLeastOneOf: ['123']),
      const Filter.inValues(field: 'f', values: ['123']),
    );
    expect(
      where('year', isBetween: ('1990', '1999')),
      const Filter.between(field: 'year', from: '1990', to: '1999'),
    );

    expect(
      or([
        and([
          where('fruit', isEqualTo: 'apple'),
          where('year', isBetween: ('2000', '2009')),
        ]),
        not(where('colors', containsAtLeastOneOf: ['red', 'green'])),
      ]),
      const Filter.or([
        Filter.and([
          Filter.equal(field: 'fruit', value: 'apple'),
          Filter.between(field: 'year', from: '2000', to: '2009'),
        ]),
        Filter.not(Filter.inValues(field: 'colors', values: ['red', 'green'])),
      ]),
      reason: 'Aggregate filters should build properly',
    );
  });

  test('Mimir.where throws exception on bad input', () {
    final where = Mimir.where;
    expect(
      () => where('', isEqualTo: '', containsAtLeastOneOf: []),
      throwsUnsupportedError,
      reason: 'Too many operators',
    );
    expect(
      () => where(''),
      throwsUnsupportedError,
      reason: 'Too few operators',
    );
  });
}
