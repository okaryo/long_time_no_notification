import 'package:long_time_no_notification/src/closed_notification.dart';

class ClosedNotifications {
  final List<ClosedNotification> values;

  const ClosedNotifications(this.values);

  ClosedNotification? findBy(String id) {
    for (final value in values) {
      if (value.id == id) return value;
    }
    return null;
  }
}
