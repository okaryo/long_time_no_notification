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

  ClosedNotifications addOrUpdate(ClosedNotification notification) {
    final hasSameIdNotification = values.any((value) => value.id == notification.id);

    if (hasSameIdNotification) {
      final newValues = values.map((value) {
        return value.id == notification.id ? notification : value;
      }).toList();
      return ClosedNotifications(newValues);
    }

    final newValues = [...values, notification];
    return ClosedNotifications(newValues);
  }

  ClosedNotifications removeBy(List<String> ids) {
    final newValues = values.where((value) {
      return ids.every((id) => id != value.id);
    }).toList();
    return ClosedNotifications(newValues);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ClosedNotifications) return false;
    if (values.length != other.values.length) return false;
    for (var i = 0; i < values.length; i++) {
      if (values[i] != other.values[i]) return false;
    }

    return true;
  }

  @override
  int get hashCode => super.hashCode;
}
