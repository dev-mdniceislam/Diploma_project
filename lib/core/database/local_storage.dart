import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _secure = FlutterSecureStorage();
  static const _webKeys = ['token', 'role', 'userId', 'remember_email'];

  Future<String?> readData({required String key}) async {
    try {
      if (kIsWeb) {
        return (await SharedPreferences.getInstance()).getString(key);
      }
      return await _secure.read(key: key);
    } catch (e) {
      log('LocalStorage read error ($key): $e');
      return null;
    }
  }

  Future<void> writeData({required String key, required String value}) async {
    try {
      if (kIsWeb) {
        await (await SharedPreferences.getInstance()).setString(key, value);
      } else {
        await _secure.write(key: key, value: value);
      }
    } catch (e) {
      log('LocalStorage write error ($key): $e');
    }
  }

  Future<void> deleteData({required String key}) async {
    try {
      if (kIsWeb) {
        await (await SharedPreferences.getInstance()).remove(key);
      } else {
        await _secure.delete(key: key);
      }
    } catch (e) {
      log('LocalStorage delete error ($key): $e');
    }
  }

  Future<void> deleteAllData() async {
    try {
      if (kIsWeb) {
        final prefs = await SharedPreferences.getInstance();
        for (final k in _webKeys) {
          await prefs.remove(k);
        }
      } else {
        await _secure.deleteAll();
      }
    } catch (e) {
      log('LocalStorage deleteAll error: $e');
    }
  }
}
