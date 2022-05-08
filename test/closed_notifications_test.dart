import 'package:flutter_test/flutter_test.dart';
import 'package:long_time_no_notification/src/closed_notification.dart';
import 'package:long_time_no_notification/src/closed_notifications.dart';

void main() {
  group('instance method', () {
    group('#findBy', () {
      group('when target value is included', () {
        test('should return target value', () {
          final actual = const ClosedNotifications([
            ClosedNotification(id: 'test_1'),
            ClosedNotification(id: 'test_2'),
            ClosedNotification(id: 'test_3'),
          ]).findBy('test_2');
          final expected = const ClosedNotification(id: 'test_2');

          expect(actual, expected);
        });
      });

      group('when target value is not included', () {
        test('should return null', () {
          final actual = const ClosedNotifications([
            ClosedNotification(id: 'test_1'),
            ClosedNotification(id: 'test_2'),
            ClosedNotification(id: 'test_3'),
          ]).findBy('test_4');

          expect(actual, isNull);
        });
      });
    });
  });
}
