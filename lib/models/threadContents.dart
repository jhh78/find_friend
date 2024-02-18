class ThreadContentsTable {
  late String id;
  late String created;
  late String updated;
  late String threadId;
  late String userId;
  late String nickname;
  late String contents;

  ThreadContentsTable({
    required this.id,
    required this.created,
    required this.updated,
    required this.threadId,
    required this.userId,
    required this.nickname,
    required this.contents,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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
    created = json['created'];
    updated = json['updated'];
    threadId = json['thread_id'];
    userId = json['user_id'];
    nickname = json['nickname'];
    contents = json['contents'];
  }
}
