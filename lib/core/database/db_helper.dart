import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (kIsWeb) return null;
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), "history_db.db");
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE history(id INTEGER PRIMARY KEY AUTOINCREMENT, key TEXT UNIQUE, data TEXT)",
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute("DROP TABLE IF EXISTS history");
          await db.execute(
            "CREATE TABLE history(id INTEGER PRIMARY KEY AUTOINCREMENT, key TEXT UNIQUE, data TEXT)",
          );
        }
      },
    );
  }

  Future<void> insertCache({
    required String key,
    required dynamic insertData,
  }) async {
    if (kIsWeb) return;

    var dbClient = await db;
    if (dbClient == null) return;

    String jsonData = jsonEncode(insertData);

    await dbClient.insert("history", {
      "key": key,
      "data": jsonData,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<dynamic> getCache({required String key}) async {
    if (kIsWeb) return null;

    var dbClient = await db;
    if (dbClient == null) return null;

    List<Map<String, dynamic>> result = await dbClient.query(
      "history",
      where: "key = ?",
      whereArgs: [key],
    );

    if (result.isNotEmpty) {
      return jsonDecode(result.first['data'] as String);
    }
    return null;
  }
}
