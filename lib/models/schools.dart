class SchoolsTable {
  late String? uuid;
  late String? sKind;
  late int? prefectures;
  late int? fKind;
  late String? zipcode;
  late String? address;
  late String? name;

  SchoolsTable({
    this.uuid,
    this.sKind,
    this.prefectures,
    this.fKind,
    this.zipcode,
    this.address,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'sKind': sKind,
      'prefectures': prefectures,
      'fKind': fKind,
      'zipcode': zipcode,
      'address': address,
      'name': name,
    };
  }

  SchoolsTable.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    sKind = json['s_kind'];
    prefectures = json['prefectures'];
    fKind = json['f_kind'];
    zipcode = json['zipcode'];
    address = json['address'];
    name = json['name'];
  }
}
