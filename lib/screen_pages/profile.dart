import 'package:fec_app2/models/profile_model.dart';
import 'package:fec_app2/providers/password_provider.dart';
import 'package:fec_app2/providers/profile_provider.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/screen_pages/login_screen.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:fec_app2/widgets/email_field.dart';
import 'package:fec_app2/widgets/name_field.dart';
import 'package:fec_app2/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileInfo extends StatefulWidget {
  static const String routeName = '/profile-info';
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  ProfileProvider profileProvider = ProfileProvider();

  List<Profile>? profileOne = [];
  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  getProfileData() async {
    profileOne = await profileProvider.getCurrentUser();
    for (int i = 0; i < profileOne!.length; i++) {
      nameController.text = profileOne![i].data.name;
      emailController.text = profileOne![i].data.email;
    }
  }

  void _submitUpdateProfileForm(BuildContext context) async {
    bool isvalid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isvalid) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<ProfileUpdateProvider>(context, listen: false)
        .onSubmittedProfileUpdation(
            context,
            nameController.text,
            emailController.text,
            passwordController.text,
            confirmPasswordController.text);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passwordProvider =
        Provider.of<PasswordProvider>(context, listen: false);
    Provider.of<ProfileDeleteProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.27,
              decoration: const BoxDecoration(),
              child: Stack(
                children: [
                  ClipPath(
                    clipper: CurvedBottomClipper5(),
                    child: Container(
                      color: Colors.amber,
                      height: 185.h,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: CurvedBottomClipper(),
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.amber,
                                height: 180.h,
                                width: 395.w,
                                child: Image.asset(
                                  'assets/images/dashboard.png',
                                  fit: BoxFit.cover,
                                  alignment: const FractionalOffset(1.5, 0.5),
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    color:
                                        const Color.fromARGB(255, 25, 74, 159)
                                            .withValues(alpha: 0.6),
                                    height: 185.h,
                                    width: 395.w,
                                  )),
                              Positioned(
                                  top: 0,
                                  left: 75,
                                  child: Image.asset(
                                      'assets/images/mainslogo.png',
                                      height: 180.h,
                                      width: 200.w)),
                              Positioned(
                                  top: 0.h,
                                  left: 0.w,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.popAndPushNamed(
                                            context, DashBoard.routeName);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.68,
                    decoration: const BoxDecoration(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Text(
                            'Profile',
                            style: TextStyle(
                                fontSize: 30.sp,
                                color: const Color.fromARGB(255, 25, 74, 159),
                                fontWeight: FontWeight.w700),
                          )),
                          SizedBox(height: 05.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.h),
                            child: Text(
                              'Name:',
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 05.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.h),
                            child: NameField(
                              nameController: nameController,
                              hintText: 'Enter your full name',
                              labelText: 'Name',
                            ),
                          ),
                          SizedBox(height: 05.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.h),
                            child: Text(
                              'Email:',
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 05.h),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.h),
                              child: EmailField(
                                  emailController: emailController,
                                  hintText: 'Enter email address here',
                                  labelText: 'Email Address')),
                          SizedBox(height: 05.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.h),
                            child: Text(
                              'Password:',
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 05.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.h),
                            child: Consumer<PasswordProvider>(
                                builder: ((context, pp, child) => PasswordField(
                                      passwordController: passwordController,
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
                          SizedBox(height: 05.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.h),
                            child: Text(
                              'Confirm password:',
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 05.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.h),
                            child: Consumer<PasswordProvider>(
                                builder: ((context, pp, child) => PasswordField(
                                      passwordController:
                                          confirmPasswordController,
                                      passwordProvider: passwordProvider,
                                      hintText: 'Enter confirm password',
                                      labelText: 'Confirm password',
                                      icon: Icon(
                                        passwordProvider.isObscure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      colors: passwordProvider.isObscure
                                          ? Colors.black
                                          : Colors.red,
                                    ))),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                              height: 45.h,
                              width: double.infinity.w,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 70.h),
                                child: TextButton(
                                    onPressed: () =>
                                        _submitUpdateProfileForm(context),
                                    style: ButtonStyle(
                                        shape: const WidgetStatePropertyAll(
                                            LinearBorder.none),
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 25, 74, 159))),
                                    child: Text('Update',
                                        style: TextStyle(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))),
                              )),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Consumer<ProfileDeleteProvider>(
                                builder: (context, proProvide, child) =>
                                    ElevatedButton(
                                  onPressed: () async {
                                    proProvide
                                        .onSubmittedProfileDelete(context);
                                  },
                                  style: ButtonStyle(
                                      shape: const WidgetStatePropertyAll(
                                          LinearBorder.none),
                                      backgroundColor: WidgetStatePropertyAll(
                                          Colors.grey.shade200),
                                      elevation:
                                          const WidgetStatePropertyAll(0)),
                                  child: proProvide.isloaderdelete == true
                                      ? Text('Delete',
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withValues(alpha: 0.6)))
                                      : const CircularProgressIndicator(
                                          color:
                                              Color.fromARGB(255, 25, 74, 159)),
                                ),
                              ),
                              SizedBox(width: 20.w),
                              ElevatedButton(
                                onPressed: () async {
                                  await logoutUser();
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                                style: ButtonStyle(
                                    shape: const WidgetStatePropertyAll(
                                        LinearBorder.none),
                                    backgroundColor: WidgetStatePropertyAll(
                                        Colors.grey.shade200),
                                    elevation: const WidgetStatePropertyAll(0)),
                                child: Text('Logout',
                                    style: TextStyle(
                                        color: Colors.black
                                            .withValues(alpha: 0.6))),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> logoutUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Fluttertoast.showToast(msg: "User Logout Successfully");
  }
}
