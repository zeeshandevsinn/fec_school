class SaveChangePasswordModel {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  SaveChangePasswordModel(
      {required this.currentPassword,
      required this.newPassword,
      required this.confirmPassword});
  factory SaveChangePasswordModel.fromMap(map) => SaveChangePasswordModel(
      currentPassword: map['currentPassword'],
      newPassword: map['newPassword'],
      confirmPassword: map['confirmPassword']);
  Map<String, dynamic> toMap() {
    return {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword
    };
  }
}
