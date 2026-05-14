import 'dart:convert';
import 'dart:developer';
import 'package:fec_app2/models/profile_model.dart';
import 'package:fec_app2/models/profile_up_model.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileProvider {
  Future<List<Profile>?> getCurrentUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    String? token = preferences.getString('token');
    List<Profile>? profileData = [];
    try {
      var url = Uri.parse(profile);
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json",
          "Accept": 'application/json',
        },
      );
      var jsonRespose = json.decode(response.body);

      if (response.statusCode == 200) {
        Profile profile = Profile.fromMap(jsonRespose);
        profileData.add(profile);
      }
    } catch (e) {
      log(e.toString());
    }
    return profileData;
  }
}

class ProfileUpdateProvider with ChangeNotifier {
  void onSubmittedProfileUpdation(BuildContext context, final name, final email,
      final password, final confirmPassoword) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    String? token = preferences.getString('token');
    UpdateProfie updateProfie = UpdateProfie(name, email);

    try {
      var response = await http.post(Uri.parse(updateProfileUpdate),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: json.encode(updateProfie.toMap()));

      var jsonRespose = jsonDecode(response.body.toString());

      if (response.statusCode == 200 || jsonRespose['status']) {
        Fluttertoast.showToast(msg: 'Account updated Successfully');
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, DashBoard.routeName);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e Account is not updated yet');
    }

    notifyListeners();
  }
}

class ProfileDeleteProvider with ChangeNotifier {
  bool _isloaderdelete = true;
  get isloaderdelete => _isloaderdelete;
  void onSubmittedProfileDelete(BuildContext context) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    String? token = preferences.getString('token');
    _isloaderdelete = false;
    try {
      var response = await http.delete(
        Uri.parse(deleteProfile),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      var jsonRespose = jsonDecode(response.body.toString());

      if (response.statusCode == 200 || jsonRespose['status']) {
        Fluttertoast.showToast(msg: 'Your account has been deleted');
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, DashBoard.routeName);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e Your account has not  been deleted');
    }
    _isloaderdelete = true;
    notifyListeners();
  }
}
