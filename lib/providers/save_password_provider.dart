import 'dart:convert';

import 'package:fec_app2/models/save_change_pass_model.dart';
import 'package:fec_app2/screen_pages/login_screen.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SavePasswordProvider with ChangeNotifier {
  SaveChangePasswordModel? saveChangePasswordModel;
  void onSubmittedSavePasswordForm(BuildContext context, final currentControll,
      final newPassword, final confirmPassword, String? token) async {
    saveChangePasswordModel = SaveChangePasswordModel(
        currentPassword: currentControll,
        newPassword: newPassword,
        confirmPassword: confirmPassword);
    try {
      var response = await http.post(Uri.parse(changeSavePassword),
          headers: {
            "Accept": 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(saveChangePasswordModel!.toMap()));
      var jsonResponse = await json.decode(json.encode(response.body));

      if (jsonResponse == true) {
        Fluttertoast.showToast(msg: 'Save & Change Password Successfully');
      }
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, LoginScreen.routeName);
    } catch (e) {
      Fluttertoast.showToast(msg: '$e SomeThing went wrong');
    }

    notifyListeners();
  }
}
