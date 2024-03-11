import 'dart:async';

import 'package:flutter/services.dart';

class SharedPref {
  final Map<String, dynamic> _values;

  SharedPref._(this._values);

  static const MethodChannel _channel = MethodChannel('com.elaunch.shared_pref');

  static SharedPref? _instance;

  static Future<SharedPref> getInstance() async {
    if (_instance != null) return _instance!;
    try {
      var values = await _channel.invokeMapMethod<String, dynamic>("getInstance");
      _instance = SharedPref._(values!);
      return _instance!;
    } on PlatformException catch (e) {
      rethrow;
    }
  }

  Future<bool> _setValue(String type, String key, dynamic value) async {
    _values[key] = value;
    var result = await _channel.invokeMethod<bool>("setValue", {
      "type": type,
      "key": key,
      "value": value,
    });
    return result ?? false;
  }

  Set<String> getKeys() => Set<String>.from(_values.keys);

  dynamic get(String key) => _values[key];

  String? getString(String key) => _values[key];

  bool? getBool(String key) => _values[key];

  double getDouble(String key) => _values[key];

  int getInt(String key) => _values[key];

  Future<bool>? setBool(String key, bool value) => _setValue("Bool", key, value);

  Future<bool>? setInt(String key, int value) => _setValue('Int', key, value);

  Future<bool>? setDouble(String key, double value) => _setValue('Double', key, value);

  Future<bool>? setString(String key, String value) => _setValue('String', key, value);
}
