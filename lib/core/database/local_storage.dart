import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<String?> readData({required String key}) async {
    return await storage.read(key: key);
  }

  Future<void> writeData({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  Future<void> deleteData({required String key}) async {
    await storage.delete(key: key);
  }

  Future<void> deleteAllData() async {
    await storage.deleteAll();
  }
}
