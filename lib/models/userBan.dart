class UserBanTable {
  late String? id;
  late String? collectionId;
  late String? collectionName;
  late String? created;
  late String? updated;
  late String? contents;

  UserBanTable({
    this.id,
    this.collectionId,
    this.collectionName,
    this.created,
    this.updated,
    this.contents,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'created': created,
      'updated': updated,
      'contents': contents,
    };
  }

  UserBanTable.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    collectionId = json['collectionId'];
    collectionName = json['collectionName'];
    created = json['created'];
    updated = json['updated'];
    contents = json['contents'];
  }
}
