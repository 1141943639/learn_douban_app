import 'package:sqflite/sqflite.dart';

class SqlManager {
  static String _NAME = 'data.db';
  static Database? database;

  static init() async {
    // 判断是否初始化
    if (database != null) return;

    database = await openDatabase('${await getDatabasesPath()}$_NAME');
  }

  static Future<bool> isTableExist(String tableName) async {
    await init();

    final res = (await database?.rawQuery(
        "SELECT 1 FROM sqlite_master WHERE type = 'table' AND name = '${tableName}'"));

    return (await database?.rawQuery(
                "SELECT 1 FROM sqlite_master WHERE type = 'table' AND name = '${tableName}'"))
            ?.isNotEmpty ??
        false;
  }
}
