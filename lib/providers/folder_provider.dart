// ignore_for_file: unused_element, unnecessary_string_interpolations
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoldersProvider {
  Future<List<Map<String, dynamic>>> getFolders() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    List<Map<String, dynamic>> folderSubForldersList = [];
    try {
      var url = Uri.parse(folder);
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      final jsonRespose = json.decode(response.body);

      if (jsonRespose["status"] == "success") {
        for (int i = 0; i < (jsonRespose["data"] as List).length; i++) {
          folderSubForldersList.add(jsonRespose["data"][i]);
        }
      }
    } catch (e, s) {
      log(e.toString());
      if (kDebugMode) {
        print(">>>>>>>>>>>>>> ${s.toString()} >>>>>>>>>>>>>>>>>");
      }
    }
    return folderSubForldersList;
  }
}
