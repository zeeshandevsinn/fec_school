import 'dart:convert';
import 'dart:developer';
import 'package:fec_app2/models/call_contact_model.dart';
import 'package:fec_app2/services.dart/urls_api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallContactsProvider with ChangeNotifier {
  List<CallContactModel> _contacts = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<CallContactModel> get contacts => _contacts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCallContacts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      final response = await http.get(
        Uri.parse(callContacts),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      log('Call Contacts Response: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'success') {
          final List<dynamic> contactsList = data['data'];
          _contacts = contactsList
              .map((contact) => CallContactModel.fromMap(contact))
              .toList();
        } else {
          _errorMessage = data['message'] ?? 'Failed to fetch call contacts';
        }
      } else {
        _errorMessage = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      log('Error fetching call contacts: $e');
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
