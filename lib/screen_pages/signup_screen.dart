import 'package:fec_app2/providers/password_provider.dart';
import 'package:fec_app2/providers/signup_provider.dart';
import 'package:fec_app2/providers/switching_provvider.dart';
import 'package:fec_app2/screen_pages/login_screen.dart';
import 'package:fec_app2/services.dart/push_notifications/notification_service.dart';
import 'package:fec_app2/widgets/email_field.dart';
import 'package:fec_app2/widgets/name_field.dart';
import 'package:fec_app2/widgets/password_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final PushNotificationServices _pushNotificationServices =
      PushNotificationServices();

  @override
  void initState() {
    _pushNotificationServices.requestForNotificationPermissions();
    _pushNotificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('===========> \n $value');
      }
    });
    _pushNotificationServices.notificationInit(context);
    _pushNotificationServices.getDeviceTokenRefreshing(context);
    _pushNotificationServices.setUpMessageInteraction(context);
    super.initState();
  }

  // ignore: unused_element
  void _submitSignUpForm(BuildContext context) {
    bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<SignUpProvider>(context, listen: false).onSubmittedSignUpForm(
        context,
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SwitchingProvider>(context, listen: false);
    final passwordProvider =
        Provider.of<PasswordProvider>(context, listen: false);
    Provider.of<SignUpProvider>(context);
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
                          width: 400.w)),
                  Positioned(
                      child: Center(
                          child: Image.asset('assets/images/mainslogo.png',
                              height: 300.h, width: 220.w))),
                  Form(
                    key: _formKey,
                    child: Padding(
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
                          elevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Column(
                            children: [
                              SizedBox(height: 20.h),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.r)),
                                    color:
                                        const Color.fromARGB(255, 25, 74, 159)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Consumer<SwitchingProvider>(
                                    builder: (context, sp, child) =>
                                        ToggleSwitch(
                                      activeBgColor: const [Colors.amber],
                                      cornerRadius: 20,
                                      radiusStyle: true,
                                      inactiveBgColor: const Color.fromARGB(
                                          255, 25, 74, 159),
                                      initialLabelIndex: sp.isValue,
                                      totalSwitches: 2,
                                      labels: const ['Login', 'SignUp'],
                                      customTextStyles: const [
                                        TextStyle(color: Colors.white)
                                      ],
                                      onToggle: (index) {
                                        sp.isSwitching(index);
                                        if (index == 0) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginScreen()));
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: NameField(
                                  nameController: _nameController,
                                  hintText: 'Enter full name',
                                  labelText: 'Name',
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: EmailField(
                                  emailController: _emailController,
                                  hintText: 'Enter email here',
                                  labelText: 'Email Address',
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Consumer<PasswordProvider>(
                                    builder: ((context, pp, child) =>
                                        PasswordField(
                                          passwordController:
                                              _passwordController,
                                          passwordProvider: passwordProvider,
                                          hintText: 'Enter password',
                                          labelText: 'Password',
                                          icon: Icon(passwordProvider.isObscure
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          colors: passwordProvider.isObscure
                                              ? Colors.black
                                              : Colors.red,
                                        ))),
                              ),

                              SizedBox(height: 30.h),
                              SizedBox(
                                  height: 50.h,
                                  width: double.infinity.w,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 60.w),
                                    child: Consumer<SignUpProvider>(
                                      builder: (context, signPro, child) =>
                                          TextButton(
                                        onPressed: () =>
                                            _submitSignUpForm(context),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    const Color.fromARGB(
                                                        255, 25, 74, 159))),
                                        child: signPro.isNotValidate
                                            ? Text(
                                                'Sign Up',
                                                style: TextStyle(
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )
                                            : const CircularProgressIndicator(
                                                color: Colors.white),
                                      ),
                                    ),
                                  )),
                              SizedBox(height: 20.h),
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
