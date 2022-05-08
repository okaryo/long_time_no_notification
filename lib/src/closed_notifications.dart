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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ClosedNotifications) return false;
    if (this.values.length != other.values.length) return false;
    for (var i = 0; i < this.values.length; i++) {
      if (this.values[i] != other.values[i]) return false;
    }

    return true;
  }

  @override
  int get hashCode => super.hashCode;
}
