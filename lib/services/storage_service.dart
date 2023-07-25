import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

///
/// Storage service.
/// Should be responsible for handling all kinds of local storage providers. Currently shared_preferences service is implemented.
///
class StorageService {
  late SharedPreferences _pref;

  bool isInitialised = false;

  StorageService();

  Future<void> init() async {
    if (isInitialised) return;
    _pref = await SharedPreferences.getInstance();
    isInitialised = true;
    print('Initialised Storage Service');
  }

  Future<void> setPrefs<T>(String key, T content) async {
    try {
      if (content is String) {
        await _pref.setString(key, content);
      } else if (content is bool) {
        await _pref.setBool(key, content);
      } else if (content is int) {
        await _pref.setInt(key, content);
      } else if (content is double) {
        await _pref.setDouble(key, content);
      } else if (content is List<String>) {
        await _pref.setStringList(key, content);
      } else if (content is List<Map<String, dynamic>>) {
        await _pref.setString(key, json.encode(content));
      }
      return;
    } catch (e, s) {
      print(e.toString());
      print(s.toString());
      rethrow;
    }
  }

  T? getPrefs<T>(String key, {T? defaultValue}) {
    try {
      if (_pref.containsKey(key)) {
        final value = _pref.get(key);
        return value as T;
      } else {
        return defaultValue;
      }
    } catch (e, s) {
      print(e.toString());
      print(s.toString());
      return null;
    }
  }

  Future<bool> removePrefs(String key) async {
    return await _pref.remove(key);
  }

  ///
  /// Reload shared preferences. This must be called in case we make local storage changes on the native side.
  ///
  Future<void> reloadPrefs() async {
    await _pref.reload();
  }
}
