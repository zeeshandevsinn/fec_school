// ignore_for_file: unused_element
import 'dart:convert';
import 'package:fec_app2/models/user_model_signin.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  bool _isNotValidate = true;
  bool get isNotValidate => _isNotValidate;

  void inLoginForm(BuildContext context, final email, final password,
      final deviceToken) async {
    // ignore: unused_local_variable
    _isNotValidate = false;
    UserModelSignIn userModelSignIn = UserModelSignIn(
        email: email, password: password, device_token_id: deviceToken);
    try {
      var response = await http.post(Uri.parse(login),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAV-elSoM:APA91bERtlmxMzz8Wg1cFDVF5moZW-H2mO36o9u-vInFJLg38l2aynsyhgMYtAPuI90jxfq8SDwxakn1X7VdsUaKQWKHEYxC4jTpd-BGxdNaLVbforIUyDsBlWMT20GBL_R9CnRzNSgS'
          },
          body: jsonEncode(userModelSignIn.toMap()));
      var jsonRespose = jsonDecode(response.body);
      if (kDebugMode) {
        print(
            '=========>++++++++++++++++++ ${userModelSignIn.device_token_id.toString()}');

        print('=========> ${response.body.toString()}');
      }

      if (jsonRespose['status']) {
        var myToken = jsonRespose['token'];
        var myName = jsonRespose['name'];

        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setString('token', myToken);
        preferences.setString('name', myName);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, DashBoard.routeName);
        Fluttertoast.showToast(msg: 'User Login Successfully');
      } else {
        Fluttertoast.showToast(msg: 'Invalid credentials');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e Error is something wrong');
    }
    _isNotValidate = true;
    notifyListeners();
  }
}
