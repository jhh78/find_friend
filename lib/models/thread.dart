class ThreadTable {
  late String? id;
  late String? collectionId;
  late String? collectionName;
  late String? created;
  late String? updated;
  late String? title;
  late String? userId;

  ThreadTable({
    this.id,
    this.collectionId,
    this.collectionName,
    this.created,
    this.updated,
    this.title,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'created': created,
      'updated': updated,
      'title': title,
      'userId': userId,
    };
  }

  ThreadTable.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    collectionId = json['collectionId'];
    collectionName = json['collectionName'];
    created = json['created'];
    updated = json['updated'];
    title = json['title'];
    userId = json['user_id'];
  }
}
