import 'package:find_friend/models/schools.dart';

class UsersTable {
  late String? id;
  late String? created;
  late String? updated;
  late String? nickname;
  late int? exp;
  late int? point;
  late String? depiction;
  late List<SchoolsTable>? schools;

  UsersTable({
    this.id,
    this.created,
    this.updated,
    this.nickname,
    this.exp,
    this.point,
    this.depiction,
    this.schools,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created': created,
      'updated': updated,
      'nickname': nickname,
      'exp': exp,
      'point': point,
      'depiction': depiction,
      'schools': schools,
    };
  }

  UsersTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    updated = json['updated'];
    nickname = json['nickname'];
    exp = json['exp'];
    point = json['point'];
    depiction = json['depiction'];
    schools = json['schools'];
  }
}
