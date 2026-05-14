class AddStrudents {
  final AddStudent data;

  AddStrudents({required this.data});

  factory AddStrudents.fromMap(map) => AddStrudents(
        data: AddStudent.fromMap(map["data"]),
      );

  Map<String, dynamic> toMap() => {"data": data.toMap()};
}

class AddStudent {
  final int id;
  final String name;
  final String childrenName;
  final String email;
  final dynamic emailVerifiedAt;
  final int role;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  AddStudent({
    required this.id,
    required this.name,
    required this.childrenName,
    required this.email,
    required this.emailVerifiedAt,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddStudent.fromMap(map) => AddStudent(
        id: map["id"] ?? 0,
        name: map["name"],
        childrenName: map["children_name"],
        email: map["email"],
        emailVerifiedAt: map["email_verified_at"],
        role: map["role"],
        status: map["status"],
        createdAt: DateTime.parse(map["created_at"]),
        updatedAt: DateTime.parse(map["updated_at"]),
      );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "children_name": childrenName,
      "email": email,
      "email_verified_at": emailVerifiedAt,
      "role": role,
      "status": status,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}
