import 'package:shared_preferences/shared_preferences.dart';

class NotificationSharedPreferences {
  static const _key = 'long_time_no_notification';

  final Future<SharedPreferences> _instance;

  const NotificationSharedPreferences(this._instance);

  Future<List<String>?> get() async {
    final prefs = await _instance;
    return prefs.getStringList(_key);
  }

  Future<bool> set(List<String> value) async {
    final prefs = await _instance;
    return prefs.setStringList(_key, value);
  }

  Future<bool> delete() async {
    final prefs = await _instance;
    return prefs.remove(_key);
  }
}
