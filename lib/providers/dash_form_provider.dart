// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class IntializeFormFieldsProvider with ChangeNotifier {
  // Map of TextEditingControllers for text-based inputs values
  Map<String, TextEditingController> textNumberFileDateControllers = {};
  Map<String, TextEditingController> filesControllers = {};

  // Variables for dropdowns values, radio buttons values, and checkboxes values
  Map<String, String?> dropdownsValue = {};
  Map<String, String?> radioButtonsValues = {};
  Map<String, List<String>> checkBoxesValues = {};

  // Handle initialization All Value
  void initializationOfControllers(String uniqueName, String type) {
    if (type == 'text' ||
        type == 'textarea' ||
        type == 'number' ||
        type == 'date') {
      textNumberFileDateControllers[uniqueName] = TextEditingController();
    } else if (type == 'select') {
      dropdownsValue[uniqueName] = null; // By-Default null
    } else if (type == 'radio-group') {
      radioButtonsValues[uniqueName] = null; // By-Default null
    } else if (type == 'checkbox-group') {
      checkBoxesValues[uniqueName] = []; // By-Default empty
    } else if (type == 'file') {
      filesControllers[uniqueName] = TextEditingController();
    }
  }

  // Set dropdowns values
  void setDropdownsValues(String uniqueName, String value) {
    dropdownsValue[uniqueName] = value;
    notifyListeners();
  }

  // Set radios values
  void setRadioButtonsValues(String uniqueName, String value) {
    radioButtonsValues[uniqueName] = value;
    notifyListeners();
  }

  // Set checkboxs values
  void togglesCheckboxesValues(String uniqueName, String value) {
    if (checkBoxesValues[uniqueName]?.contains(value) ?? false) {
      checkBoxesValues[uniqueName]?.remove(value);
    } else {
      checkBoxesValues[uniqueName]?.add(value);
    }
    notifyListeners();
  }

  // Dispose all controllers values for Text, Number , Files and Dates
  void disposesControllers() {
    textNumberFileDateControllers
        .forEach((key, controller) => controller.dispose());
  }
}

/// Form Submition For Forms

class SubmissionProcessForFormProvider with ChangeNotifier {
  void submissionProcessFormData(
      BuildContext context,
      int? id,
      Map<String, TextEditingController> textNumberFileDateControllers,
      Map<String, TextEditingController> filesControllers,
      Map<String, List<String>> checkBoxesValues,
      Map<String, String?> radioButtonsValues,
      Map<String, String?> dropdownsValue) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> textNumberFileDateValue = {};
    Map<String, String> checkboxes = {};
    Map<String, String> radiobuttons = {};
    Map<String, String> dropDowns = {};
    textNumberFileDateControllers.forEach(
      (key, value) {
        textNumberFileDateValue.addAll({key: value.text});
      },
    );
    checkBoxesValues.forEach(
      (key, value) {
        for (var element in value) {
          checkboxes.addAll({key: element});
        }
      },
    );
    radiobuttons =
        radioButtonsValues.map((key, value) => MapEntry(key, value ?? ''));
    dropDowns = dropdownsValue.map((key, value) => MapEntry(key, value ?? ''));
    // ignore: unused_local_variable
    String? token = preferences.getString('token');

    Map<String, String> formDataValuesMap = {
      ...textNumberFileDateValue,
      ...checkboxes,
      ...radiobuttons,
      ...dropDowns,
    };

    String formUpdation = '$updateForm$id';
    try {
      var request = http.MultipartRequest('POST', Uri.parse(formUpdation));
      request.headers['Authorization'] = "Bearer $token";
      for (var entry in filesControllers.entries) {
        String? filePath = entry.value.text;
        if (filePath.isNotEmpty) {
          var file = await http.MultipartFile.fromPath(entry.key, filePath);
          request.files.add(file);
        }
      }
      request.fields.addAll(formDataValuesMap);
      var response = await request.send();

      if (response.statusCode == 200) {
        var resposeData = await http.Response.fromStream(response);
        log(resposeData.body.toString());
        Fluttertoast.showToast(msg: 'Form uploaded Successfully');
        Navigator.pushReplacementNamed(context, DashBoard.routeName);
      }
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(msg: '$e Form is not uploaded yet');
    }

    notifyListeners();
  }
}
