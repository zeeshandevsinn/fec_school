// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UpdateProfie {
  final String name;
  final String email;
  String? password;
  String? confirmPassword;

  UpdateProfie(this.name, this.email, [this.password, this.confirmPassword]);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  factory UpdateProfie.fromMap(Map<String, dynamic> map) {
    return UpdateProfie(
      map['name'] as String,
      map['email'] as String,
      map['password'] != null ? map['password'] as String : null,
      map['confirmPassword'] != null ? map['confirmPassword'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateProfie.fromJson(String source) =>
      UpdateProfie.fromMap(json.decode(source) as Map<String, dynamic>);
}
