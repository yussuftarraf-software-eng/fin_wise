import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _sharedPreferences;
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> set({required String key, required dynamic value}) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is List<String>) {
      await _sharedPreferences.setStringList(key, value);
    } else {
      throw "Invalid value type";
    }
  }

  static dynamic get({required String key}) {
    return _sharedPreferences.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  static Future<bool> clearAllSavedData() async {
    return await _sharedPreferences.clear();
  }

  static List<String>? getStringList({required String key}) =>
      _sharedPreferences.getStringList(key);
}
