import 'dart:convert';

import 'package:long_time_no_notification/src/closed_notification.dart';
import 'package:long_time_no_notification/src/closed_notifications.dart';

class NotificationMapper {
  static List<String> toJson(ClosedNotifications notifications) {
    return notifications.values.map((value) => jsonEncode(value.toJson())).toList();
  }

  static ClosedNotifications fromJson(List<String> jsonList) {
    final values = jsonList.map((json) {
      final Map<String, String?> map = Map.from(jsonDecode(json));
      return ClosedNotification.fromJson(map);
    }).toList();

    return ClosedNotifications(values);
  }
}
