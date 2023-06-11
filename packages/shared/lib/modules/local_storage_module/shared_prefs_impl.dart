import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_module.dart';

class SharedPrefLocalStorageImpl extends LocalStorageModule {
  late SharedPreferences _prefs;
  Completer initCompleter = Completer();

  SharedPrefLocalStorageImpl() {
    SharedPreferences.getInstance().then((value) {
      _prefs = value;
      initCompleter.complete();
    });
  }

  Future<void> _ensureInit() async {
    if (initCompleter.isCompleted) return;
    await initCompleter.future;
  }

  @override
  Future<T?> get<T>(String key) async {
    await _ensureInit();
    if (T is String) {
      return _prefs.getString(key) as T?;
    }
    if (T is bool) {
      return _prefs.getBool(key) as T?;
    }
    if (T is int) {
      return _prefs.getInt(key) as T?;
    }
    if (T is double) {
      return _prefs.getDouble(key) as T?;
    }
    if (T is List<String>) {
      return _prefs.getStringList(key) as T?;
    }

    if (T is Map<String, dynamic>) {
      var jsonData = _prefs.getString(key);
      if (jsonData != null) {
        return jsonDecode(jsonData) as T;
      }
    }
    return null;
  }

  @override
  Future<void> set<T>(String key, T value) async {
    await _ensureInit();
    switch (T) {
      case String:
        await _prefs.setString(key, value as String);
        return;
      case bool:
        await _prefs.setBool(key, value as bool);
        return;
      case int:
        await _prefs.setInt(key, value as int);
        return;
      case double:
        await _prefs.setDouble(key, value as double);
        return;
      case const (List<String>):
        await _prefs.setStringList(key, value as List<String>);
        return;
      case const (Map<String, dynamic>):
        await _prefs.setString(key, jsonEncode(value));
        return;
    }
    throw UnimplementedError();
  }

  @override
  Future<void> remove<T>(String key) async {
    await _ensureInit();
    await _prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    await _ensureInit();
    _prefs.clear();
  }
}
