class UsersTable {
  late String? id;
  late String? collectionId;
  late String? collectionName;
  late String? username;
  late String? created;
  late String? updated;
  late String? depiction;

  UsersTable({
    this.id,
    this.collectionId,
    this.collectionName,
    this.username,
    this.created,
    this.updated,
    this.depiction,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'username': username,
      'created': created,
      'updated': updated,
      'depiction': depiction,
    };
  }

  UsersTable.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    collectionId = json['collectionId'];
    collectionName = json['collectionName'];
    username = json['username'];
    created = json['created'];
    updated = json['updated'];
    depiction = json['depiction'];
  }
}
