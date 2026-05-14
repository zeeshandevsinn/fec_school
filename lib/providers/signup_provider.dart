// ignore_for_file: use_build_context_synchronously

// import 'dart:convert';
// import 'dart:developer';
// import 'package:fec_app2/models/user_model_signup.dart';
// import 'package:fec_app2/screen_pages/login_screen.dart';
// import 'package:fec_app2/services.dart/urls_api.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:developer';
import 'package:fec_app2/screen_pages/login_screen.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../models/user_model_signup.dart';

class SignUpProvider with ChangeNotifier {
  bool _isNotValidate = true;
  bool get isNotValidate => _isNotValidate;

  Future<void> onSubmittedSignUpForm(BuildContext context, String username,
      String email, String password) async {
    _isNotValidate = false;
    notifyListeners();

    UserModelSignup userModelSignup = UserModelSignup(
      name: username,
      email: email,
      password: password,
    );

    try {
      var response = await http.post(
        Uri.parse(registration),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(userModelSignup.toMap()),
      );

      var jsonResponse = jsonDecode(response.body.toString());
      log("API Response: ${response.body}");

      if (response.statusCode == 200 && jsonResponse['status']) {
        log("Signup Success!");

        // Show Alert Dialog
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text('Please wait'),
                content: const Text(
                    'Account created successfully, pending for approval'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        String errorMsg =
            jsonResponse['message'] ?? 'Signup failed. Try again.';
        log("Signup Error: $errorMsg");

        Fluttertoast.showToast(
          msg: errorMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      log("Error: $e");

      Fluttertoast.showToast(
        msg: "Something went wrong: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }

    _isNotValidate = true;
    notifyListeners();
  }
}

// class SignUpProvider with ChangeNotifier {
//   bool _isNotValidate = true;
//   get isNotValidate => _isNotValidate;
//   void onSubmittedSignUpForm(
//       BuildContext context, final username, final email, final password) async {
//     // ignore: unused_local_variable
//     _isNotValidate = false;
//     UserModelSignup? userModelSignup =
//         UserModelSignup(name: username, email: email, password: password);
//     try {
//       var response = await http.post(Uri.parse(registration),
//           headers: {
//             'Accept': 'application/json',
//             'Content-Type': 'application/json',
//           },
//           body: json.encode(userModelSignup.toMap()));

//       var jsonRespose = jsonDecode(response.body.toString());

//       if (response.statusCode == 200 || jsonRespose['status']) {
//         showDialog(
//           context: context,
//           builder: (BuildContext dialogContext) {
//             return AlertDialog(
//               title: const Text('Please wait'),
//               content: const Text(
//                   'Account created successfully, pending for approval'),
//               actions: <Widget>[
//                 TextButton(
//                   child: const Text('OK'),
//                   onPressed: () {
//                     Navigator.of(dialogContext).pop(); // Close dialog
//                     Navigator.pushReplacementNamed(
//                         context, LoginScreen.routeName);
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } catch (e) {
//       log(e.toString());
//       // Fluttertoast.showToast(
//       //     msg: '$e - Account is not created yet', gravity: ToastGravity.BOTTOM);
//     }

//     _isNotValidate = true;
//     notifyListeners();
//   }
// }
