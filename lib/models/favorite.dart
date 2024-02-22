class FavoriteTable {
  late String? threadId;

  FavoriteTable({
    this.threadId,
  });

  Map<String, dynamic> toMap() {
    return {
      'thread_id': threadId,
    };
  }

  FavoriteTable.fromJson(Map<String, dynamic> json) {
    threadId = json['thread_id'];
  }
}
