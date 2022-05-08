import 'package:flutter_test/flutter_test.dart';
import 'package:long_time_no_notification/src/closed_notification.dart';
import 'package:long_time_no_notification/src/closed_notifications.dart';
import 'package:long_time_no_notification/src/notification_repository.dart';
import 'package:long_time_no_notification/src/notification_shared_preferences.dart';
import 'package:mockito/mockito.dart';

import './mock/mock.mocks.dart';

void main() {
  final NotificationSharedPreferences sharedPreferences = MockNotificationSharedPreferences();
  final NotificationRepository repository = NotificationRepositoryImpl(sharedPreferences);

  group('#getNotifications', () {
    group('when any data is not saved in shared preferences', () {
      setUp(() {
        when(sharedPreferences.get()).thenAnswer((_) async => null);
      });

      test('should return empty notifications', () async {
        final actual = await repository.getNotifications();
        final expected = const ClosedNotifications([]);

        expect(actual, expected);
        verify(sharedPreferences.get()).called(1);
      });
    });

    group('when data is already saved in shared preferences', () {
      setUp(() {
        when(sharedPreferences.get()).thenAnswer((_) async => [
              '{"id":"test_1","last_display_at":null,"next_display_at":null}',
              '{"id":"test_2","last_display_at":"2022-05-08 00:00:00.000","next_display_at":"2022-05-09 00:00:00.000"}',
              '{"id":"test_3","last_display_at":"2022-05-09 00:00:00.000","next_display_at":"2022-05-10 00:00:00.000"}'
            ]);
      });

      test('should return notifications', () async {
        final actual = await repository.getNotifications();
        final expected = ClosedNotifications([
          const ClosedNotification(id: 'test_1'),
          ClosedNotification(id: 'test_2', lastDisplayAt: DateTime(2022, 5, 8), nextDisplayAt: DateTime(2022, 5, 9)),
          ClosedNotification(id: 'test_3', lastDisplayAt: DateTime(2022, 5, 9), nextDisplayAt: DateTime(2022, 5, 10)),
        ]);

        expect(actual, expected);
        verify(sharedPreferences.get()).called(1);
      });
    });
  });

  group('#setNotificaions', () {
    group('when any data is not saved in shared preferences', () {
      setUp(() {
        when(sharedPreferences.get()).thenAnswer((_) async => null);
        when(sharedPreferences.set([
          '{"id":"test_1","last_display_at":null,"next_display_at":null}',
        ])).thenAnswer((_) async => true);
      });

      test('should return bool', () async {
        final actual = await repository.setNotification(const ClosedNotification(id: 'test_1'));

        expect(actual, isTrue);
        verify(sharedPreferences.get()).called(1);
        verify(sharedPreferences.set([
          '{"id":"test_1","last_display_at":null,"next_display_at":null}',
        ])).called(1);
      });
    });

    group('when data is already saved in shared preferences', () {
      setUp(() {
        when(sharedPreferences.get()).thenAnswer((_) async => [
              '{"id":"test_1","last_display_at":null,"next_display_at":null}',
              '{"id":"test_2","last_display_at":"2022-05-08 00:00:00.000","next_display_at":"2022-05-09 00:00:00.000"}',
            ]);
        when(sharedPreferences.set([
          '{"id":"test_1","last_display_at":null,"next_display_at":null}',
          '{"id":"test_2","last_display_at":"2022-05-08 00:00:00.000","next_display_at":"2022-05-09 00:00:00.000"}',
          '{"id":"test_3","last_display_at":"2022-05-09 00:00:00.000","next_display_at":"2022-05-10 00:00:00.000"}'
        ])).thenAnswer((_) async => true);
      });

      test('should return bool', () async {
        final actual = await repository.setNotification(
          ClosedNotification(id: 'test_3', lastDisplayAt: DateTime(2022, 5, 9), nextDisplayAt: DateTime(2022, 5, 10)),
        );

        expect(actual, isTrue);
        verify(sharedPreferences.get()).called(1);
        verify(sharedPreferences.set([
          '{"id":"test_1","last_display_at":null,"next_display_at":null}',
          '{"id":"test_2","last_display_at":"2022-05-08 00:00:00.000","next_display_at":"2022-05-09 00:00:00.000"}',
          '{"id":"test_3","last_display_at":"2022-05-09 00:00:00.000","next_display_at":"2022-05-10 00:00:00.000"}'
        ])).called(1);
      });
    });
  });

  group('#clear', () {
    group('when any data is not saved in shared preferences', () {
      setUp(() {
        when(sharedPreferences.get()).thenAnswer((_) async => null);
        when(sharedPreferences.set([])).thenAnswer((_) async => true);
      });

      test('should return bool', () async {
        final actual = await repository.clear(['test_1', 'test_2']);

        expect(actual, isTrue);
        verify(sharedPreferences.get()).called(1);
        verify(sharedPreferences.set([])).called(1);
      });
    });

    group('when data is already saved in shared preferences', () {
      setUp(() {
        when(sharedPreferences.get()).thenAnswer((_) async => [
              '{"id":"test_1","last_display_at":null,"next_display_at":null}',
              '{"id":"test_2","last_display_at":"2022-05-08 00:00:00.000","next_display_at":"2022-05-09 00:00:00.000"}',
              '{"id":"test_3","last_display_at":"2022-05-09 00:00:00.000","next_display_at":"2022-05-10 00:00:00.000"}'
            ]);
        when(sharedPreferences.set([
          '{"id":"test_2","last_display_at":"2022-05-08 00:00:00.000","next_display_at":"2022-05-09 00:00:00.000"}',
        ])).thenAnswer((_) async => true);
      });

      test('should return bool', () async {
        final actual = await repository.clear(['test_1', 'test_3']);

        expect(actual, isTrue);
        verify(sharedPreferences.get()).called(1);
        verify(sharedPreferences.set([
          '{"id":"test_2","last_display_at":"2022-05-08 00:00:00.000","next_display_at":"2022-05-09 00:00:00.000"}',
        ])).called(1);
      });
    });
  });

  group('#clearAll', () {
    setUp(() {
      when(sharedPreferences.set([])).thenAnswer((_) async => true);
    });

    test('should return bool', () async {
      final actual = await repository.clearAll();

      expect(actual, isTrue);
      verify(sharedPreferences.set([])).called(1);
    });
  });
}
