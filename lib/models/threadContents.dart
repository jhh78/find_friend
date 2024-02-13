class ThreadContentsTable {
  late String? id;
  late String? collectionId;
  late String? collectionName;
  late String? created;
  late String? updated;
  late String? threadId;
  late String? userId;
  late String? nickname;
  late String? contents;

  ThreadContentsTable({
    this.id,
    this.collectionId,
    this.collectionName,
    this.created,
    this.updated,
    this.threadId,
    this.userId,
    this.nickname,
    this.contents,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'collection_id': collectionId,
      'collection_name': collectionName,
      'created': created,
      'updated': updated,
      'thread_id': threadId,
      'user_id': userId,
      'nickname': nickname,
      'contents': contents,
    };
  }

  ThreadContentsTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    collectionId = json['collection_id'];
    collectionName = json['collection_name'];
    created = json['created'];
    updated = json['updated'];
    threadId = json['thread_id'];
    userId = json['user_id'];
    nickname = json['nickname'];
    contents = json['contents'];
  }
}
