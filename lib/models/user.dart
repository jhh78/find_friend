class UsersTable {
  late String? id;
  late String? collectionId;
  late String? collectionName;
  late String? username;
  late bool? verified;
  late bool? emailVisibility;
  late String? email;
  late String? created;
  late String? updated;
  late String? depiction;

  UsersTable({
    this.id,
    this.collectionId,
    this.collectionName,
    this.username,
    this.verified,
    this.emailVisibility,
    this.email,
    this.created,
    this.updated,
    this.depiction,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'username': username,
      'verified': verified,
      'emailVisibility': emailVisibility,
      'email': email,
      'created': created,
      'updated': updated,
      'depiction': depiction,
    };
  }

  UsersTable.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    collectionId = json['collectionId'];
    collectionName = json['collectionName'];
    username = json['username'];
    verified = json['verified'];
    emailVisibility = json['emailVisibility'];
    email = json['email'];
    created = json['created'];
    updated = json['updated'];
    depiction = json['depiction'];
  }
}
