class Profile {
  final Data data;

  Profile({required this.data});

  factory Profile.fromMap(Map<String, dynamic> json) =>
      Profile(data: Data.fromMap(json["data"]));

  Map<String, dynamic> toMap() => {"data": data.toMap()};
}

class Data {
  final int id;
  final String name;
  final dynamic childrenName;
  final String email;
  final dynamic emailVerifiedAt;
  final String deviceTokenId;
  final int role;
  final int status;
  final dynamic createdAt;
  final DateTime updatedAt;

  Data(
      {required this.id,
      required this.name,
      required this.childrenName,
      required this.email,
      required this.emailVerifiedAt,
      required this.deviceTokenId,
      required this.role,
      required this.status,
      required this.createdAt,
      required this.updatedAt});

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        childrenName: json["children_name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        deviceTokenId: json["device_token_id"],
        role: json["role"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "children_name": childrenName,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "device_token_id": deviceTokenId,
        "role": role,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
      };
}


