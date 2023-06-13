// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:copy_to_app/common/sqlite/base_db_provider.dart';
import 'package:copy_to_app/common/sqlite/sql_manager.dart';
import 'package:copy_to_app/utils/log_helper.dart';

class UserModel {
  String? phone;
  String? password;

  UserModel({
    this.phone,
    this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['password'] = this.password;
    return data;
  }

  UserModel copyWith({
    String? phone,
    String? password,
  }) {
    return UserModel(
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': phone,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      phone: map['phone'] != null ? map['phone'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  @override
  String toString() => 'UserModel(phone: $phone, password: $password)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.phone == phone && other.password == password;
  }

  @override
  int get hashCode => phone.hashCode ^ password.hashCode;
}

class UserDBProvider extends BaseDBProvider {
  UserDBProvider();

  @override
  get tableName => 'UserInfo';

  @override
  get createSql {
    final json = UserModel().toJson();

    json['phone'] = 'text';
    json['password'] = 'text';

    return jsonToCreateSql(json);
  }

  Future<UserModel?> getUserByPhone(String phone) async {
    try {
      final User = await SqlManager.database
          ?.query(tableName, where: 'phone = ?', whereArgs: [phone]);

      return UserModel.fromMap(User!.first);
    } catch (error, stackTrace) {
      LogHelper.error(error, stackTrace);
    }

    return null;
  }
}
