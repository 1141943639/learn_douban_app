import 'package:copy_to_app/common/sqlite/sql_manager.dart';

abstract class BaseDBProvider {
  get createSql => '';
  get tableName => '';

  Future<void> open() async {
    bool isTableExist = await SqlManager.isTableExist(tableName);

    if (!isTableExist) {
      SqlManager.database?.rawQuery(createSql);
    }
  }

  String jsonToCreateSql(Map<String, dynamic> json) {
    List<String> sql = [];

    json.entries.forEach((element) {
      sql.add('${element.key} ${element.value}');
    });

    return 'create table $tableName (${sql.join(', ')})';
  }

  Future<int?> inert(Map<String, dynamic> json) async {
    return SqlManager.database?.insert(tableName, json);
  }
}
