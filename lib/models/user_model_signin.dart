// ignore_for_file: non_constant_identifier_names

class UserModelSignIn {
  final String email;
  final String password;
  final String device_token_id;

  UserModelSignIn(
      {required this.email,
      required this.password,
      required this.device_token_id});

  factory UserModelSignIn.fromMap(map) => UserModelSignIn(
      email: map["email"],
      password: map["password"],
      device_token_id: map['device_token_id']);

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "password": password,
      "device_token_id": device_token_id
    };
  }
}
