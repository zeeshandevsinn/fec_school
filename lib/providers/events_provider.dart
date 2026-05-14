// ignore_for_file: unused_element, unused_local_variable, unnecessary_string_interpolations
import 'dart:convert';
import 'dart:developer';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EventsProvider {
  Future<List<Map<String, dynamic>>> getsUsers() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    List<Map<String, dynamic>> eventsList = [];
    try {
      var url = Uri.parse(event);
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
          eventsList.add(jsonRespose["data"][i]);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return eventsList;
  }
}

/// Forms Provider
class FormsProvider {
  Future<List<Map<String, dynamic>>> getsForms() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    List<Map<String, dynamic>> formsList = [];
    try {
      var url = Uri.parse(getFormDashboard);
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
          formsList.add(jsonRespose["data"][i]);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return formsList;
  }
}

/// Single Form Accessing

class FormsSingleProvider with ChangeNotifier {
  Future<List<Map<String, dynamic>>> getsSingleForms(int? id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    final List<Map<String, dynamic>> formsSingleValue = [];

    try {
      String singleFormAPI = '$getSingleForm$id';

      var url = Uri.parse(singleFormAPI);
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
        for (int i = 0; i < (jsonRespose as List).length; i++) {
          formsSingleValue.add(jsonRespose[i]);
        }
        // log("message ${_formsSingleValue.asMap()}");
      }
    } catch (e) {
      log(e.toString());
    }
    return formsSingleValue;
  }
}
