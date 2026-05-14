// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously, unused_local_variable
import 'dart:convert';
import 'package:fec_app2/models/student_info_model.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:fec_app2/models/textformfield_model.dart';
import 'package:fec_app2/services.dart/urls_api.dart';

class ChildInfoProvider with ChangeNotifier {
  void onSubmittedStudentsForm(
      BuildContext context,
      List<TextFormFieldModel> textFields,
      String token,
      List<TextFormFieldClassModel> textFieldsClass) async {
    // Map<String, dynamic> student = {
    //   "children_name": [textFields.elementAt(0).text.toString()]
    // };

    List<String> listOfStudents = [];
    List<String> listOfClasses = [];
    if (textFields.length == textFieldsClass.length) {
      Map<String, dynamic> students = {
        "children_name": [
          for (int i = 0; i < textFields.length; i++)
            textFields[i].studentName.toString()
        ]
      };
      listOfStudents = List.from(students["children_name"]);
      Map<String, dynamic> classes = {
        "class_name": [
          for (int i = 0; i < textFieldsClass.length; i++)
            textFieldsClass[i].className.toString()
        ]
      };

      listOfClasses = List.from(classes["class_name"]);
    } else {
      Fluttertoast.showToast(
          msg:
              'Class or Student name must be required if you entered student or class name');
    }

    bool isNotValidate = false;
    StudentInfoModel studentInfoModel = StudentInfoModel(
        childrenName: listOfStudents, className: listOfClasses);

    try {
      var response = await http.post(Uri.parse(postStudents),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(studentInfoModel.toJson()));

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: ' Student with class created successfully');
        Navigator.pushReplacementNamed(context, DashBoard.routeName);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e Something Went Wrong');
    }

    notifyListeners();
  }
}

class VisbilityProvider with ChangeNotifier {
  bool _isVisibility = false;
  get isVisibility => _isVisibility;

  void isVisibilityVisibile() {
    _isVisibility = true;
    notifyListeners();
  }

  void isVisibilityGone() {
    _isVisibility = false;
    notifyListeners();
  }
}
