class SystemTable {
  late String? kind;
  late String? data;

  SystemTable({
    this.kind,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'kind': kind,
      'data': data,
    };
  }

  SystemTable.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    data = json['data'];
  }
}
