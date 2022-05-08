import 'package:flutter_test/flutter_test.dart';
import 'package:long_time_no_notification/src/closed_notification.dart';

void main() {
  group('factory constructor', () {
    group('#forever', () {
      test('should create instance only with id', () {
        final actual = ClosedNotification.foreverNoDisplay('test_id');
        final expected = const ClosedNotification(id: 'test_id', lastDisplayAt: null, nextDisplayAt: null);

        expect(actual, expected);
      });
    });

    group('#interval', () {
      test('should create instance with duration property', () {
        final actual = ClosedNotification.interval(
          'test_id',
          DateTime.parse('2022-05-08 14:48:54.965'),
          const Duration(days: 1, minutes: 11, milliseconds: 5),
        );
        final expected = ClosedNotification(
          id: 'test_id',
          lastDisplayAt: DateTime(2022, 5, 8, 14, 48, 54, 965),
          nextDisplayAt: DateTime(2022, 5, 9, 14, 59, 54, 970),
        );

        expect(actual, expected);
      });
    });

    group('#fromJson', () {
      group('when last_display_at key is null', () {
        test('should return instance with only id', () {
          final actual = ClosedNotification.fromJson({
            'id': 'test_1',
            'last_display_at': null,
            'next_display_at': null,
          });
          final expected = const ClosedNotification(id: 'test_1');

          expect(actual, expected);
        });
      });

      group('when last_display_at key is not null', () {
        test('should return instance with lastDisplayAt and nextDisplayAt', () {
          final actual = ClosedNotification.fromJson({
            'id': 'test_1',
            'last_display_at': '2022-05-08 14:48:54.965',
            'next_display_at': '2022-05-09 14:59:54.970',
          });
          final expected = ClosedNotification(
            id: 'test_1',
            lastDisplayAt: DateTime(2022, 5, 8, 14, 48, 54, 965),
            nextDisplayAt: DateTime(2022, 5, 9, 14, 59, 54, 970),
          );

          expect(actual, expected);
        });
      });
    });
  });

  group('instance method', () {
    group('#toJson', () {
      group('when instance has only id', () {
        test('should return json whose displayAt key is null', () {
          final actual = ClosedNotification.foreverNoDisplay('test_id').toJson();
          final expected = {
            'id': 'test_id',
            'last_display_at': null,
            'next_display_at': null,
          };

          expect(actual, expected);
        });
      });

      group('when instance has lastDisplayAt and nextDisplayAt', () {
        test('should return json whose displayAt key is present', () {
          final actual = ClosedNotification.interval(
            'test_id',
            DateTime.parse('2022-05-08 14:48:54.965'),
            const Duration(days: 1, minutes: 11, milliseconds: 5),
          ).toJson();
          final expected = {
            'id': 'test_id',
            'last_display_at': '2022-05-08 14:48:54.965',
            'next_display_at': '2022-05-09 14:59:54.970',
          };

          expect(actual, expected);
        });
      });
    });
  });
}
