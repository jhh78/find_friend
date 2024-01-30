class SchoolInfoTable {
  late String? id;
  late String? collectionId;
  late String? collectionName;
  late String? created;
  late String? updated;
  late String? code;
  late int? graduateYear;

  SchoolInfoTable({
    this.id,
    this.collectionId,
    this.collectionName,
    this.created,
    this.updated,
    this.code,
    this.graduateYear,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'created': created,
      'updated': updated,
      'code': code,
      'graduateYear': graduateYear,
    };
  }

  SchoolInfoTable.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    collectionId = json['collectionId'];
    collectionName = json['collectionName'];
    created = json['created'];
    updated = json['updated'];
    code = json['code'];
    graduateYear = json['graduate_year'];
  }
}
