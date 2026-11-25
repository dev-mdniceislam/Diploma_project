import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_user_model.dart';

class AuthLocalDataSource {
  const AuthLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  static const _sessionKey = 'auth_session';

  Future<void> saveSession(AuthUserModel user) =>
      _prefs.setString(_sessionKey, jsonEncode(user.toJson()));
}
