import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const stringkey = 'stringkey';

class LocalDate {
  static salvarstring(String valor) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString(stringkey, valor);
    debugPrint("$valor Salvo");
  }

  static Future<String> getString() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    return shared.getString(stringkey) ?? "Vazio";
  }
}

class UserSimplePreferences {
  // ignore: unused_field
  static late SharedPreferences _preferences;
  static const _keyname = 'username';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setUsername(String username) async =>
      await _preferences.setString(_keyname, username);
  static String? getUsername() => _preferences.getString(_keyname);
}
