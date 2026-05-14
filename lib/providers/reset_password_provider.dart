import 'dart:convert';
import 'package:fec_app2/models/forget_pass_model.dart';
import 'package:fec_app2/screen_pages/login_screen.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ResetPasswordProvider with ChangeNotifier {
  ForgetPassEmail? forgetPassEmail;
  onSubmittedResetPasswordForm(BuildContext context, final resetEmail) async {
    forgetPassEmail = ForgetPassEmail(email: resetEmail.toString());
    try {
      var response = await http.post(Uri.parse(forgetPassword),
          headers: {
            "Accept": 'application/json',
            'Content-Type': 'application/json'
          },
          body: json.encode(forgetPassEmail!.toMap()));

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: 'Email has been sent with password reset link');
      }
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, LoginScreen.routeName);
    } catch (e) {
      Fluttertoast.showToast(msg: 'SomeThing went wrong');
    }

    notifyListeners();
  }
}
