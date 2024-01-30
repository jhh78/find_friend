class ThreadContentsTable {
  late String? id;
  late String? collectionId;
  late String? collectionName;
  late String? created;
  late String? updated;
  late String? threadId;
  late String? contents;

  ThreadContentsTable({
    this.id,
    this.collectionId,
    this.collectionName,
    this.created,
    this.updated,
    this.threadId,
    this.contents,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'created': created,
      'updated': updated,
      'threadId': threadId,
      'contents': contents,
    };
  }

  ThreadContentsTable.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    collectionId = json['collectionId'];
    collectionName = json['collectionName'];
    created = json['created'];
    updated = json['updated'];
    threadId = json['threadId'];
    contents = json['contents'];
  }
}
