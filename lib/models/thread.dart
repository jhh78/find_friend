class ThreadTable {
  late String? id;
  late String? created;
  late String? schoolCode;
  late String? userId;
  late String? title;
  late String? depiction;

  ThreadTable({
    this.id,
    this.created,
    this.schoolCode,
    this.userId,
    this.title,
    this.depiction,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created': created,
      'school_code': schoolCode,
      'user_id': userId,
      'title': title,
      'depiction': depiction,
    };
  }

  factory ThreadTable.fromJson(Map<String, dynamic> json) {
    return ThreadTable(
      id: json['id'],
      created: json['created'],
      schoolCode: json['school_code'],
      userId: json['user_id'],
      title: json['title'],
      depiction: json['depiction'],
    );
  }
}
