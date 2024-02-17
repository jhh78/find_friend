class UsersTable {
  late String? id;
  late String? created;
  late String? updated;
  late String? nickname;
  late int? exp;

  UsersTable({
    this.id,
    this.created,
    this.updated,
    this.nickname,
    this.exp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created': created,
      'updated': updated,
      'nickname': nickname,
      'exp': exp,
    };
  }

  UsersTable.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    updated = json['updated'];
    nickname = json['nickname'];
    exp = json['exp'];
  }
}
