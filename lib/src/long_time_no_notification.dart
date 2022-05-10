import 'package:long_time_no_notification/src/closed_notification.dart';
import 'package:long_time_no_notification/src/notification_repository.dart';
import 'package:long_time_no_notification/src/notification_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// For example, this class can be useful when a notification is confirmed and should not be displayed for a few days.
///
/// You can choose not to display the notification forever or for a certain period of time.
class LongTimeNoNotification {
  static final Future<SharedPreferences> _instance = SharedPreferences.getInstance();
  static final NotificationSharedPreferences _sharedPreferences = NotificationSharedPreferences(_instance);
  static final NotificationRepository _repository = NotificationRepositoryImpl(_sharedPreferences);

  final ClosedNotification _notification;

  LongTimeNoNotification._(this._notification);

  /// Prevent the notification of the target ID from being displayed forever.
  static Future<LongTimeNoNotification> setForever({required String id}) async {
    return LongTimeNoNotificationDelegate.set(
      id: id,
      currentDateTime: DateTime.now(),
      repository: _repository,
    );
  }

  /// From the date and time this method is called, the notification for the target ID will not be displayed for the `Duration` passed as an argument.
  static Future<LongTimeNoNotification> setDuration({required String id, required Duration duration}) {
    return LongTimeNoNotificationDelegate.set(
      id: id,
      currentDateTime: DateTime.now(),
      duration: duration,
      repository: _repository,
    );
  }

  /// Retrieves the corresponding ID's notification data from SharedPreferences.
  ///
  /// If the data is not found, this will return null.
  static Future<LongTimeNoNotification?> findBy(String id) {
    return LongTimeNoNotificationDelegate.findBy(id, _repository);
  }

  /// Deletes all notification data from SharedPreferences.
  static Future<bool> clearAll() {
    return LongTimeNoNotificationDelegate.resetAll(_repository);
  }

  /// Deletes data from SharedPreferences for the notification whose IDs are passed as an argument.
  static Future<bool> clear(List<String> ids) {
    return LongTimeNoNotificationDelegate.clear(ids, _repository);
  }

  /// If notification was closed with `setForever`, this will return true.
  bool get isForever => _notification.isForever;

  /// DateTime last displayed.
  ///
  /// If notification was closed with `setForever`, this will always return null.
  DateTime? get lastDisplayAt => _notification.lastDisplayAt;

  /// DateTime to be displayed next.
  ///
  /// If notification was closed with `setForever`, this will always return null.
  DateTime? get nextDisplayAt => _notification.nextDisplayAt;

  /// If `DateTime.now()` is after `nextDisplayAt`, this returns true.
  bool shouldNotify() {
    return _notification.shouldNotify(DateTime.now());
  }
}

class LongTimeNoNotificationDelegate {
  final ClosedNotification notification;
  final NotificationRepository repository;

  LongTimeNoNotificationDelegate({
    required this.notification,
    required this.repository,
  });

  static Future<LongTimeNoNotification?> findBy(String id, NotificationRepository repository) async {
    final notifications = await repository.getNotifications();
    final notification = notifications.findBy(id);
    if (notification == null) return null;

    return LongTimeNoNotification._(notification);
  }

  static Future<bool> resetAll(NotificationRepository repository) {
    return repository.clearAll();
  }

  static Future<bool> clear(List<String> ids, NotificationRepository repository) {
    return repository.clear(ids);
  }

  static Future<LongTimeNoNotification> set({
    required String id,
    bool? forever,
    Duration? duration,
    required DateTime currentDateTime,
    required NotificationRepository repository,
  }) async {
    final notification = duration == null
        ? ClosedNotification.foreverNoDisplay(id)
        : ClosedNotification.interval(id, currentDateTime, duration);

    await repository.setNotification(notification);

    return LongTimeNoNotification._(notification);
  }
}
