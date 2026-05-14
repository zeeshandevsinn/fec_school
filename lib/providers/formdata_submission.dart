import 'dart:developer';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FormDataSubmissionProvider with ChangeNotifier {
  void submissionFormData(
    BuildContext context,
    String? formId,
    Map<String, TextEditingController> initializeTextController,
    Map<String, TextEditingController> initializeDateController,
    Map<String, TextEditingController> initializeNumController,
    Map<String, TextEditingController> initializeFileController,
    Map<String, List<String>> selectedCheckboxValues,
    Map<String, String> selectedDropValues,
    Map<String, String> selectedRadioValue,
    Map<String, TextEditingController> initializeTextAreaController,
  ) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    String? token = preferences.getString('token');
    Map<String, String> textKeysValues = {};
    Map<String, String> dateKeysValues = {};
    Map<String, String> numKeysValues = {};
    Map<String, String> textAreaKeysValues = {};
    Map<String, String> checksValues = {};
    initializeTextController.forEach((key, value) {
      textKeysValues.addAll({key: value.text});
    });
    initializeDateController.forEach((key, value) {
      dateKeysValues.addAll({key: value.text});
    });
    initializeNumController.forEach((key, value) {
      numKeysValues.addAll({key: value.text});
    });
    initializeTextAreaController.forEach((key, value) {
      textAreaKeysValues.addAll({key: value.text});
    });
    selectedCheckboxValues.forEach((key, value) {
      for (var element in value) {
        checksValues.addAll({key: element});
      }
    });

    Map<String, String> formDataValuesMap = {
      ...textKeysValues,
      ...dateKeysValues,
      ...numKeysValues,
      ...checksValues,
      ...selectedRadioValue,
      ...selectedDropValues,
      ...textAreaKeysValues,
    };

    String formUpdation = '$updateForm$formId';
    try {
      var request = http.MultipartRequest('POST', Uri.parse(formUpdation));
      request.headers['Authorization'] = "Bearer $token";
      for (var entry in initializeFileController.entries) {
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
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, DashBoard.routeName);
      }
    } catch (e) {
      log(e.toString());

      Fluttertoast.showToast(msg: '$e Form is not uploaded yet');
    }

    notifyListeners();
  }
}
