class ForgetPassEmail {
  final String email;

  ForgetPassEmail({required this.email});
  factory ForgetPassEmail.fromMap(map) => ForgetPassEmail(email: map["email"]);
  Map<String, dynamic> toMap() {
    return {"email": email};
  }
}
