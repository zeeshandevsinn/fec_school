// ignore_for_file: use_build_context_synchronously

import 'package:fec_app2/providers/password_provider.dart';
import 'package:fec_app2/providers/save_password_provider.dart';
import 'package:fec_app2/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavePassword extends StatefulWidget {
  static const String routeName = '/save-password';
  const SavePassword({super.key});

  @override
  State<SavePassword> createState() => _SavePasswordState();
}

class _SavePasswordState extends State<SavePassword> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _submitSavePasswordForm(BuildContext context) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<SavePasswordProvider>(context, listen: false)
        .onSubmittedSavePasswordForm(
            context,
            _currentPasswordController.text.trim(),
            _newPasswordController.text.trim(),
            _confirmPasswordController.text.trim(),
            token);
  }

  @override
  void dispose() {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passwordProvider =
        Provider.of<PasswordProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Image.asset('assets/images/mainpage.png',
                      // alignment: const FractionalOffset(0, 2),
                      height: 380.h,
                      width: double.infinity,
                      fit: BoxFit.cover),
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        color: const Color.fromARGB(255, 25, 74, 159)
                            .withValues(alpha: 0.6),
                        height: 400.h,
                        width: 400.w,
                      )),
                  Positioned(
                      child: Center(
                          child: Image.asset('assets/images/mainslogo.png',
                              height: 300.h, width: 220.w))),
                  Padding(
                    padding: EdgeInsets.only(top: 280.h),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.r),
                            topRight: Radius.circular(25.r)),
                      ),
                      child: Card(
                        margin: const EdgeInsets.all(05),
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: 60.h),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Consumer<PasswordProvider>(
                                    builder: ((context, pp, child) =>
                                        PasswordField(
                                          passwordController:
                                              _currentPasswordController,
                                          passwordProvider: passwordProvider,
                                          hintText: 'Enter Current password',
                                          labelText: 'Current password',
                                          icon: Icon(passwordProvider.isObscure
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          colors: passwordProvider.isObscure
                                              ? Colors.black
                                              : Colors.red,
                                        ))),
                              ),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Consumer<PasswordProvider>(
                                    builder: ((context, pp, child) =>
                                        PasswordField(
                                          passwordController:
                                              _newPasswordController,
                                          passwordProvider: passwordProvider,
                                          hintText: 'Enter New password',
                                          labelText: 'New password',
                                          icon: Icon(passwordProvider.isObscure
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          colors: passwordProvider.isObscure
                                              ? Colors.black
                                              : Colors.red,
                                        ))),
                              ),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Consumer<PasswordProvider>(
                                    builder: ((context, pp, child) =>
                                        PasswordField(
                                          passwordController:
                                              _confirmPasswordController,
                                          passwordProvider: passwordProvider,
                                          hintText: 'Enter confirm password',
                                          labelText: 'Confirm password',
                                          icon: Icon(passwordProvider.isObscure
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          colors: passwordProvider.isObscure
                                              ? Colors.black
                                              : Colors.red,
                                        ))),
                              ),
                              SizedBox(height: 20.h),
                              SizedBox(
                                  height: 50.h,
                                  width: double.infinity.w,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 60.w),
                                    child: TextButton(
                                        onPressed: () {
                                          _submitSavePasswordForm(context);
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    const Color.fromARGB(
                                                        255, 25, 74, 159))),
                                        child: Text('Save Password',
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white))),
                                  )),
                              SizedBox(height: 30.h),

                              // Padding(
                              //   padding: const EdgeInsets.all(15),
                              //   child: Align(
                              //     alignment: Alignment.center,
                              //     child: RichText(
                              //       text: TextSpan(
                              //         children: [
                              //           TextSpan(
                              //             text: 'Allready have an account!',
                              //             style: TextStyle(
                              //               color: Colors.black,
                              //               fontWeight: FontWeight.bold,
                              //               fontSize: 16.sp,
                              //             ),
                              //           ),
                              //           TextSpan(
                              //               text: 'Login',
                              //               style: TextStyle(
                              //                   color: Colors.red,
                              //                   fontWeight: FontWeight.bold,
                              //                   fontSize: 18.sp),
                              //               recognizer: TapGestureRecognizer()
                              //                 ..onTap = () => Navigator.push(
                              //                     context,
                              //                     MaterialPageRoute(
                              //                         builder: (context) =>
                              //                             const LoginScreen())))
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
