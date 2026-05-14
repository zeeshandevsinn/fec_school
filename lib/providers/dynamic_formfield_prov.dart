// ignore_for_file: prefer_final_fields

import 'package:fec_app2/models/textformfield_model.dart';
import 'package:flutter/material.dart';

class TextFormFieldsProvider extends ChangeNotifier {
  List<TextFormFieldModel> _textFields = [TextFormFieldModel(studentName: "")];
  List<TextFormFieldModel> get textFields => _textFields;

  void addTextField(String text) {
    _textFields.add(TextFormFieldModel(studentName: text));
    notifyListeners();
  }

  void removeTextField(int index) {
    if (_textFields.length > 1) {
      _textFields.removeAt(index);
      notifyListeners();
    }
  }
}

class TextFormFieldsClassProvider extends ChangeNotifier {
  List<TextFormFieldClassModel> _textFieldsClass = [
    TextFormFieldClassModel(className: "")
  ];
  List<TextFormFieldClassModel> get textFieldsClass => _textFieldsClass;

  void addTextField(String text) {
    _textFieldsClass.add(TextFormFieldClassModel(className: text));
    notifyListeners();
  }

  void removeTextField(int index) {
    if (_textFieldsClass.length > 1) {
      _textFieldsClass.removeAt(index);
      notifyListeners();
    }
  }
}
