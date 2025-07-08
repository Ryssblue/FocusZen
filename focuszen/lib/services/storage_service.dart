import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<int> getFocusMinutes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('focus_minutes') ?? 25;
  }

  static Future<void> setFocusMinutes(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('focus_minutes', minutes);
  }

  static Future<bool> getNotificationSetting() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notifications') ?? true;
  }

  static Future<void> setNotificationSetting(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('notifications', enabled);
  }

  static Future<int> getSessionCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('focus_sessions') ?? 0;
  }

  static Future<void> incrementSessionCount() async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt('focus_sessions') ?? 0;
    prefs.setInt('focus_sessions', current + 1);
  }
}
