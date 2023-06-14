import 'package:copy_to_app/common/sqlite/sql_manager.dart';

abstract class BaseDBProvider {
  String get createSql => '';
  String get tableName => '';

  Future<void> open() async {
    var isTableExist = await SqlManager.isTableExist(tableName);

    if (!isTableExist) {
      await SqlManager.database?.rawQuery(createSql);
    }
  }

  String jsonToCreateSql(Map<String, dynamic> json) {
    var sql = <String>[];

    for (var element in json.entries) {
      sql.add('${element.key} ${element.value}');
    }

    return 'create table $tableName (${sql.join(', ')})';
  }

  Future<int?> inert(Map<String, dynamic> json) async {
    return SqlManager.database?.insert(tableName, json);
  }
}
