// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:developer';
import 'package:fec_app2/models/checkbox_model.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CheckBoxProvider with ChangeNotifier {
  Map<String, List<String>> _selectedCheckboxValues = {};
  Map<String, List<String>> get selectedCheckboxValues =>
      _selectedCheckboxValues;

  Future<void> apiAccessCheckBoxes(int? id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
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
      if (response.statusCode == 200) {
        for (int i = 0; i < (jsonRespose['data'] as List).length; i++) {
          for (int j = 0;
              j < (jsonRespose['data'][i]["form_data"] as List).length;
              j++) {
            if (jsonRespose['data'][i]["form_data"][j]["type"] ==
                "checkbox-group") {
              List<Map<String, dynamic>> dataDynamic =
                  List<Map<String, dynamic>>.from(
                      jsonRespose['data'][i]["form_data"][j]["values"]);
              List<CheckboxModel> checkboxListOne =
                  dataDynamic.map((e) => CheckboxModel.fromMap(e)).toList();
              List<String> defaultSelected = checkboxListOne
                  .where((element) => element.selected == true)
                  .map((e) => e.value)
                  .toList();
              initializeCheckboxes(
                  groupName: jsonRespose['data'][i]["form_data"][j]["name"],
                  defaultSelected: defaultSelected);

              notifyListeners();
            }
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  List<String> getSelectUnselectCheckboxes(String groupName) {
    return _selectedCheckboxValues[groupName] ?? [];
  }

  void selectUnselectCheckboxes(
      bool? isSelected, String value, String groupName) {
    if (_selectedCheckboxValues[groupName] == null) {
      _selectedCheckboxValues[groupName] = [];
    }

    if (isSelected!) {
      _selectedCheckboxValues[groupName]!.add(value);
    } else {
      _selectedCheckboxValues[groupName]!.remove(value);
    }

    notifyListeners();
  }

  void initializeCheckboxes(
      {required groupName, required List<String> defaultSelected}) {
    if (_selectedCheckboxValues[groupName] == null) {
      _selectedCheckboxValues[groupName] = defaultSelected;
    }
    notifyListeners();
  }
}
