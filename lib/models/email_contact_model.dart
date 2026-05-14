import 'dart:convert';

class EmailContactModel {
  final int id;
  final String name;
  final String email;
  final String isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  EmailContactModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EmailContactModel.fromMap(Map<String, dynamic> map) {
    return EmailContactModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      isActive: map['is_active'] ?? '0',
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  factory EmailContactModel.fromJson(String source) =>
      EmailContactModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());
}
