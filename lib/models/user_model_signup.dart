class UserModelSignup {
  final String name;
  final String email;
  final String password;

  UserModelSignup(
      {required this.name, required this.email, required this.password});

  factory UserModelSignup.fromMap(map) => UserModelSignup(
      name: map["name"], email: map["email"], password: map["password"]);

  Map<String, dynamic> toMap() {
    return {"name": name, "email": email, "password": password};
  }
}
