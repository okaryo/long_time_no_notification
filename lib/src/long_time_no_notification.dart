import 'package:long_time_no_notification/src/closed_notification.dart';
import 'package:long_time_no_notification/src/notification_repository.dart';
import 'package:long_time_no_notification/src/notification_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LongTimeNoNotification {
  static final Future<SharedPreferences> _instance = SharedPreferences.getInstance();
  static final NotificationSharedPreferences _sharedPreferences = NotificationSharedPreferences(_instance);
  static final NotificationRepository _repository = NotificationRepositoryImpl(_sharedPreferences);

  final ClosedNotification _notification;

  LongTimeNoNotification._(this._notification);

  static Future<LongTimeNoNotification> setForever({required String id}) async {
    return LongTimeNoNotificationDelegate.set(
      id: id,
      currentDateTime: DateTime.now(),
      repository: _repository,
    );
  }

  static Future<LongTimeNoNotification> setDuration({required String id, required Duration duration}) {
    return LongTimeNoNotificationDelegate.set(
      id: id,
      currentDateTime: DateTime.now(),
      duration: duration,
      repository: _repository,
    );
  }

  static Future<LongTimeNoNotification?> findBy(String id) {
    return LongTimeNoNotificationDelegate.findBy(id, _repository);
  }

  static Future<bool> clearAll() {
    return LongTimeNoNotificationDelegate.resetAll(_repository);
  }

  static Future<bool> clear(List<String> ids) {
    return LongTimeNoNotificationDelegate.clear(ids, _repository);
  }

  bool get isForever => _notification.isForever;

  DateTime? get lastDisplayAt => _notification.lastDisplayAt;

  DateTime? get nextDisplayAt => _notification.nextDisplayAt;

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
