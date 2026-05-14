import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeProvider with ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final firstDate = DateTime(1980);
  final lastDate = DateTime(2050);
  dateTimePicker(BuildContext context) async {
    DateTime? timeDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: firstDate,
        lastDate: lastDate);
    if (timeDate != null) {
      selectedDate = timeDate;
      return dateFormat.format(selectedDate);
    }
    notifyListeners();
  }
}
