import 'dart:convert';

class CallContactModel {
  final int id;
  final String name;
  final String number;
  final String isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  CallContactModel({
    required this.id,
    required this.name,
    required this.number,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CallContactModel.fromMap(Map<String, dynamic> map) {
    return CallContactModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      number: map['number'] ?? '',
      isActive: map['is_active'] ?? '0',
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  factory CallContactModel.fromJson(String source) =>
      CallContactModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());
}
