import 'package:fec_app2/providers/password_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required TextEditingController passwordController,
    required this.passwordProvider,
    required this.hintText,
    required this.labelText,
    required this.icon,
    required this.colors,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;
  final PasswordProvider passwordProvider;
  final String hintText;
  final String labelText;
  final Icon icon;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: passwordProvider.isObscure,
      controller: _passwordController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: hintText,
        label: Text(labelText,
            style: TextStyle(fontSize: 16.sp, color: Colors.black)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(width: 3, color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(width: 3, color: Colors.grey)),
        prefixIcon: const Icon(Icons.vpn_key, color: Colors.black),
        suffixIcon: IconButton(
          onPressed: () => passwordProvider.isToggleObscure(),
          icon: icon,
          color: colors,
        ),
      ),
    );
  }
}
