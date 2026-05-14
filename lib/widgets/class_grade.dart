import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClassGrade extends StatelessWidget {
  const ClassGrade({
    super.key,
    required TextEditingController classController,
  }) : _classController = classController;

  final TextEditingController _classController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _classController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: 'Enter your class grade',
        label: Text('Class grade',
            style: TextStyle(fontSize: 16.sp, color: Colors.black)),
        prefixIcon: const Icon(Icons.person, color: Colors.black),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(width: 3, color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(width: 3, color: Colors.grey)),
      ),
    );
  }
}
