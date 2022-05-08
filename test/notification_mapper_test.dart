import 'package:flutter_test/flutter_test.dart';
import 'package:long_time_no_notification/src/closed_notification.dart';
import 'package:long_time_no_notification/src/closed_notifications.dart';
import 'package:long_time_no_notification/src/notification_mapper.dart';

void main() {
  group('#toJson', () {
    test('should return json list', () {
      final notifications = ClosedNotifications([
        const ClosedNotification(id: 'test_1'),
        ClosedNotification(id: 'test_2', lastDisplayAt: DateTime(2022, 5, 8), nextDisplayAt: DateTime(2022, 5, 9)),
        ClosedNotification(id: 'test_3', lastDisplayAt: DateTime(2022, 5, 9), nextDisplayAt: DateTime(2022, 5, 10)),
      ]);

      final actual = NotificationMapper.toJson(notifications);
      final expected = [
        '{"id":"test_1","last_display_at":null,"next_display_at":null}',
        '{"id":"test_2","last_display_at":"2022-05-08 00:00:00.000","next_display_at":"2022-05-09 00:00:00.000"}',
        '{"id":"test_3","last_display_at":"2022-05-09 00:00:00.000","next_display_at":"2022-05-10 00:00:00.000"}'
      ];

      expect(actual, expected);
    });
  });

  group('#fromJson', () {
    test('should return notifications', () {
      final json = [
        '{"id":"test_1","last_display_at":null,"next_display_at":null}',
        '{"id":"test_2","last_display_at":"2022-05-08 00:00:00.000","next_display_at":"2022-05-09 00:00:00.000"}',
        '{"id":"test_3","last_display_at":"2022-05-09 00:00:00.000","next_display_at":"2022-05-10 00:00:00.000"}'
      ];

      final actual = NotificationMapper.fromJson(json);
      final expected = ClosedNotifications([
        const ClosedNotification(id: 'test_1'),
        ClosedNotification(id: 'test_2', lastDisplayAt: DateTime(2022, 5, 8), nextDisplayAt: DateTime(2022, 5, 9)),
        ClosedNotification(id: 'test_3', lastDisplayAt: DateTime(2022, 5, 9), nextDisplayAt: DateTime(2022, 5, 10)),
      ]);

      expect(actual, expected);
    });
  });
}
