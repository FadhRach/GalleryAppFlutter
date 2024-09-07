import 'package:sqflite/sqflite.dart' as sql;

import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DataHelper {
  static Future<Database> database() async {
    final datapath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(datapath, 'image.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_image(id TEXT PRIMARY KEY, title TEXT, image TEXT, description TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DataHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DataHelper.database();
    return db.query(table);
  }

  static Future<int> delete(String table, String id) async {
    final db = await DataHelper.database();
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
