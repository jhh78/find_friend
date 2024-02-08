class NoticeTable {
  late String id;
  late String title;
  late String content;
  late String created;
  late String updated;

  NoticeTable({
    required this.id,
    required this.title,
    required this.content,
    required this.created,
    required this.updated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created': created,
      'updated': updated,
    };
  }

  NoticeTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    created = json['created'];
    updated = json['updated'];
  }
}
