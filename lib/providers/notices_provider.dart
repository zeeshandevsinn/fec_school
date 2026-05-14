import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fec_app2/services.dart/urls_api.dart';

class ApiService {
  Future<List<Map<String, dynamic>>> getUsers() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    final List<Map<String, dynamic>> noticesLists = [];
    String? token = preferences.getString('token');
    try {
      var url = Uri.parse(noticeList);
      print(url);
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      var jsonRespose = json.decode(response.body);
      print(jsonRespose.toString());

      if (response.statusCode == 200) {
        for (int i = 0; i < (jsonRespose["data"] as List).length; i++) {
          noticesLists.add(jsonRespose["data"][i]);
        }
      }
    } catch (e, s) {
      log(e.toString());
      if (kDebugMode) {
        print(">>>>>>>>>>>>>> ${s.toString()} >>>>>>>>>>>>>>>>>");
      }
    }
    print("Notice list   == ${noticesLists}");

    return noticesLists;

  }

  Future<List<Map<String, dynamic>>> getUserSingle(int? id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> noticesLists = [];
    // ignore: unused_local_variable
    String? token = preferences.getString('token');

    // ignore: unnecessary_brace_in_string_interps
    String noticeAPI = '$notice$id';

    try {
      var url = Uri.parse(noticeAPI);
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      var jsonRespose = json.decode(response.body);
      // log("${jsonRespose}");
      if (response.statusCode == 200) {
        for (int i = 0; i < (jsonRespose['data'] as List).length; i++) {
          noticesLists.add(jsonRespose['data'][i]);
        }
      }
    } catch (e, s) {
      log(e.toString());
      if (kDebugMode) {
        print(" ${s.toString()} >>>>>>>>>>>>>>>>>");
      }
    }
    return noticesLists;
  }
}

class NoticesIdsProvider {
  Future<List<Map<String, dynamic>>> getIdsData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    final List<Map<String, dynamic>> noticesLists = [];
    String? token = preferences.getString('token');
    try {
      var url = Uri.parse(noticeList);
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      var jsonRespose = json.decode(response.body);

      if (response.statusCode == 200) {
        for (int i = 0; i < (jsonRespose["data"] as List).length; i++) {
          noticesLists.add(jsonRespose["data"][i]);
        }
      }
    } catch (e, s) {
      log(e.toString());
      if (kDebugMode) {
        print(">>>>>>>>>>>>>> ${s.toString()} ");
      }
    }
    return noticesLists;
  }
}
