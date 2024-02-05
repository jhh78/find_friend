class UserDetailTable {
  late String? id;
  late String? collectionId;
  late String? collectionName;
  late String? created;
  late String? updated;
  late String? nickName;
  late int? exp;

  UserDetailTable({
    this.id,
    this.collectionId,
    this.collectionName,
    this.created,
    this.updated,
    this.nickName,
    this.exp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'created': created,
      'updated': updated,
      'nickName': nickName,
      'exp': exp,
    };
  }

  UserDetailTable.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    collectionId = json['collectionId'];
    collectionName = json['collectionName'];
    created = json['created'];
    updated = json['updated'];
    nickName = json['nickName'];
    exp = json['exp'];
  }
}
