import 'package:fec_app2/providers/notices_provider.dart';
import 'package:flutter/material.dart';

class InitialTextformfieldProvider with ChangeNotifier {
  final Map<String, TextEditingController> _initializeTextController = {};
  final Map<String, TextEditingController> _initializeDateController = {};
  final Map<String, TextEditingController> _initializeNumController = {};
  final Map<String, TextEditingController> _initializeFileController = {};
  final Map<String, TextEditingController> _initializeTextAreaController = {};

  bool _isloading = true;
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> _particularForm = [];

  List<Map<String, dynamic>>? get particularForm => _particularForm;
  bool get isloading => _isloading;

  Map<String, TextEditingController> get initializeTextController =>
      _initializeTextController;
  Map<String, TextEditingController> get initializeDateController =>
      _initializeDateController;
  Map<String, TextEditingController> get initializeNumController =>
      _initializeNumController;
  Map<String, TextEditingController> get initializeFileController =>
      _initializeFileController;
  Map<String, TextEditingController> get initializeTextAreaController =>
      _initializeTextAreaController;

  Future<void> getCurrentNoticeWithProvider(int? id) async {
    _isloading = false;
    List<Map<String, dynamic>> noticeData = await _apiService.getUserSingle(id);
    for (int i = 0; i < noticeData.length; i++) {
      _particularForm.add(noticeData[i]);
      print("Particular Form ${_particularForm}");
    }
    notifyListeners();
    _isloading = true;
  }

  TextEditingController? getInitailizerTextController(String? label) {
    return _initializeTextController.putIfAbsent(
        label!, () => TextEditingController());
  }

  TextEditingController? getInitailizerDateController(String? label) {
    return _initializeDateController.putIfAbsent(
        label!, () => TextEditingController());
  }

  TextEditingController? getInitailizerNumController(String? label) {
    return _initializeNumController.putIfAbsent(
        label!, () => TextEditingController());
  }

  TextEditingController? getInitailizerFileController(String? label) {
    return _initializeFileController.putIfAbsent(
        label!, () => TextEditingController());
  }

  TextEditingController? getInitailizerTextAreaController(String? label) {
    return _initializeTextAreaController.putIfAbsent(
        label!, () => TextEditingController());
  }

  initializationControllers() {
    _particularForm = [];
    for (int i = 0; i < _particularForm.length; i++) {
      for (int j = 0;
          j < (_particularForm[i]["form_data"] as List).length;
          j++) {
        if (_particularForm[i]["form_data"][j]["type"] == "text") {
          _initializeTextController[_particularForm[i]["form_data"][j]
              ["label"]] = TextEditingController();
        } else if (_particularForm[i]["form_data"][j]["type"] == "date") {
          _initializeDateController[_particularForm[i]["form_data"][j]
              ["label"]] = TextEditingController();
        } else if (_particularForm[i]["form_data"][j]["type"] == "number") {
          _initializeNumController[_particularForm[i]["form_data"][j]
              ["label"]] = TextEditingController();
        } else if (_particularForm[i]["form_data"][j]["type"] == "file") {
          _initializeFileController[_particularForm[i]["form_data"][j]
              ["label"]] = TextEditingController();
        } else if (_particularForm[i]["form_data"][j]["type"] == "textarea") {
          _initializeTextAreaController[_particularForm[i]["form_data"][j]
              ["label"]] = TextEditingController();
        }
      }
      
    }
     
   
  }

  void dispositionController() {
    for (var element in _initializeTextController.values) {
      element.dispose();
    }
    for (var element in _initializeDateController.values) {
      element.dispose();
    }
    for (var element in _initializeNumController.values) {
      element.dispose();
    }
    for (var element in _initializeFileController.values) {
      element.dispose();
    }
    for (var element in _initializeTextAreaController.values) {
      element.dispose();
    }
  }
}
