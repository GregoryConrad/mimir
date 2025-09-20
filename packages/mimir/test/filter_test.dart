import 'package:mimir/mimir.dart';
import 'package:mimir/src/native/proto/instance/request.pb.dart';
import 'package:test/test.dart';

void main() {
  test('Filter convenience produces correct filters', () {
    final and = Mimir.and;
    final or = Mimir.or;
    final not = Mimir.not;
    final where = Mimir.where;

    expect(
      where('f', isEqualTo: 'abc'),
      Filter(
        equal: Filter_Comparison(field_1: 'f', value: 'abc'),
      ),
    );
    expect(
      where('f', isNotEqualTo: 'abc'),
      Filter(
        notEqual: Filter_Comparison(field_1: 'f', value: 'abc'),
      ),
    );
    expect(
      where('f', isGreaterThanOrEqualTo: 'abc'),
      Filter(
        greaterThanOrEqual: Filter_Comparison(field_1: 'f', value: 'abc'),
      ),
    );
    expect(
      where('f', isLessThanOrEqualTo: 'abc'),
      Filter(
        lessThanOrEqual: Filter_Comparison(field_1: 'f', value: 'abc'),
      ),
    );
    expect(
      where('f', isGreaterThan: 'abc'),
      Filter(
        greaterThan: Filter_Comparison(field_1: 'f', value: 'abc'),
      ),
    );
    expect(
      where('f', isLessThan: 'abc'),
      Filter(
        lessThan: Filter_Comparison(field_1: 'f', value: 'abc'),
      ),
    );
    expect(
      where('f', exists: true),
      Filter(exists: Filter_Field(field_1: 'f')),
    );
    expect(
      where('f', exists: false),
      Mimir.not(Filter(exists: Filter_Field(field_1: 'f'))),
    );
    expect(
      where('f', isNull: true),
      Filter(isNull: Filter_Field(field_1: 'f')),
    );
    expect(
      where('f', isNull: false),
      Mimir.not(Filter(isNull: Filter_Field(field_1: 'f'))),
    );
    expect(
      where('f', isEmpty: true),
      Filter(isEmpty: Filter_Field(field_1: 'f')),
    );
    expect(
      where('f', isEmpty: false),
      Mimir.not(Filter(isEmpty: Filter_Field(field_1: 'f'))),
    );
    expect(
      where('f', containsAtLeastOneOf: ['123']),
      Filter(
        inValues: Filter_InValues(field_1: 'f', values: ['123']),
      ),
    );
    expect(
      where('year', isBetween: ('1990', '1999')),
      Filter(
        between: Filter_Between(field_1: 'year', from: '1990', to: '1999'),
      ),
    );

    expect(
      or([
        and([
          where('fruit', isEqualTo: 'apple'),
          where('year', isBetween: ('2000', '2009')),
        ]),
        not(where('colors', containsAtLeastOneOf: ['red', 'green'])),
      ]),
      Filter(
        or: Filter_Filters(
          filters: [
            Filter(
              and: Filter_Filters(
                filters: [
                  Filter(
                    equal: Filter_Comparison(field_1: 'fruit', value: 'apple'),
                  ),
                  Filter(
                    between: Filter_Between(
                      field_1: 'year',
                      from: '2000',
                      to: '2009',
                    ),
                  ),
                ],
              ),
            ),
            Filter(
              not: Filter(
                inValues: Filter_InValues(
                  field_1: 'colors',
                  values: ['red', 'green'],
                ),
              ),
            ),
          ],
        ),
      ),
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
