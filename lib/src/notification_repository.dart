import 'package:long_time_no_notification/src/closed_notification.dart';
import 'package:long_time_no_notification/src/closed_notifications.dart';
import 'package:long_time_no_notification/src/notification_mapper.dart';
import 'package:long_time_no_notification/src/notification_shared_preferences.dart';

abstract class NotificationRepository {
  Future<ClosedNotifications> getNotifications();
  Future<bool> setNotification(ClosedNotification notification);
  Future<bool> clear(List<String> ids);
  Future<bool> clearAll();
}

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationSharedPreferences _sharedPreferences;

  const NotificationRepositoryImpl(this._sharedPreferences);

  @override
  Future<ClosedNotifications> getNotifications() async {
    final rawStringList = await _sharedPreferences.get();
    if (rawStringList == null) return const ClosedNotifications([]);

    return NotificationMapper.fromJson(rawStringList);
  }

  @override
  Future<bool> setNotification(ClosedNotification notification) async {
    final rawStringList = await _sharedPreferences.get();
    final notifications =
        rawStringList == null ? const ClosedNotifications([]) : NotificationMapper.fromJson(rawStringList);
    final newNotifications = notifications.addOrUpdate(notification);
    final json = NotificationMapper.toJson(newNotifications);

    return _sharedPreferences.set(json);
  }

  @override
  Future<bool> clear(List<String> idsToClear) async {
    final rawStringList = await _sharedPreferences.get();
    final notifications =
        rawStringList == null ? const ClosedNotifications([]) : NotificationMapper.fromJson(rawStringList);
    final newNotifications = notifications.removeBy(idsToClear);
    final json = NotificationMapper.toJson(newNotifications);

    return _sharedPreferences.set(json);
  }

  @override
  Future<bool> clearAll() async {
    return _sharedPreferences.set([]);
  }
}
