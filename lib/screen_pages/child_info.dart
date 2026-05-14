// ignore_for_file: use_build_context_synchronously

import 'package:fec_app2/providers/child_info_provider.dart';
import 'package:fec_app2/providers/dynamic_formfield_prov.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChildInformation extends StatefulWidget {
  static const String routeName = '/child-info';
  const ChildInformation({super.key});

  @override
  State<ChildInformation> createState() => _ChildInformationState();
}

class _ChildInformationState extends State<ChildInformation> {
  final _formKey = GlobalKey<FormState>();

  void _submitStudentForm(BuildContext context) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<ChildInfoProvider>(context, listen: false)
        .onSubmittedStudentsForm(
      context,
      Provider.of<TextFormFieldsProvider>(context, listen: false).textFields,
      token!,
      Provider.of<TextFormFieldsClassProvider>(context, listen: false)
          .textFieldsClass,
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TextFormFieldsProvider>(context, listen: false);
    final classProvider =
        Provider.of<TextFormFieldsClassProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.29,
              decoration: const BoxDecoration(),
              child: Stack(
                children: [
                  ClipPath(
                    clipper: CurvedBottomClipper5(),
                    child: Container(
                      color: Colors.amber,
                      height: 200.h,
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
                                height: 195.h,
                                width: 400.w,
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
                                        const Color.fromARGB(255, 25, 74, 159),
                                    height: 211.h,
                                    width: 400.w,
                                  )),
                              Positioned(
                                  left: 80,
                                  child: Center(
                                      child: Image.asset(
                                          'assets/images/mainslogo.png',
                                          height: 180.h,
                                          width: 200.w))),
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
              child: Container(
                height: MediaQuery.of(context).size.height * 0.66,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          SizedBox(height: 10.h),
                          Center(
                              child: Text(
                            'Student Info',
                            style: TextStyle(
                                fontSize: 30.sp,
                                color: const Color.fromARGB(255, 25, 74, 159),
                                fontWeight: FontWeight.w700),
                          )),
                          SizedBox(height: 05.h),
                          Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.h),
                              child: Consumer<TextFormFieldsProvider>(
                                builder: (context, studentProvider, child) {
                                  return ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        studentProvider.textFields.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Student no.${index + 1} & class name:',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.black),
                                          ),
                                          SizedBox(height: 05.h),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  initialValue: studentProvider
                                                      .textFields[index]
                                                      .studentName,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    hintText: "Enter Name here",
                                                    label: Text("Student Name",
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            color:
                                                                Colors.black)),
                                                    prefixIcon: const Icon(
                                                        Icons.person,
                                                        color: Colors.black),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 3,
                                                                    color: Colors
                                                                        .grey)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                            borderSide:
                                                                const BorderSide(
                                                                    width: 3,
                                                                    color: Colors
                                                                        .grey)),
                                                  ),
                                                  onChanged: (newText) {
                                                    studentProvider
                                                        .textFields[index]
                                                        .studentName = newText;
                                                  },
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter student name';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.add_box,
                                                    color: Color.fromARGB(
                                                        255, 25, 74, 159)),
                                                onPressed: () {
                                                  studentProvider
                                                      .addTextField("");
                                                  classProvider
                                                      .addTextField("");
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Are you want to add new student');
                                                },
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 4.h),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    initialValue: classProvider
                                                        .textFieldsClass[index]
                                                        .className,
                                                    keyboardType:
                                                        TextInputType.name,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "Enter Class here",
                                                      label: Text("Class Name",
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              color: Colors
                                                                  .black)),
                                                      prefixIcon: const Icon(
                                                          Icons.school,
                                                          color: Colors.black),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 3,
                                                                  color: Colors
                                                                      .grey)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          borderSide:
                                                              const BorderSide(
                                                                  width: 3,
                                                                  color: Colors
                                                                      .grey)),
                                                    ),
                                                    onChanged: (newText) {
                                                      classProvider
                                                          .textFieldsClass[
                                                              index]
                                                          .className = newText;
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter class name';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.delete,
                                                      color: Colors.red),
                                                  onPressed: () {
                                                    studentProvider
                                                        .removeTextField(index);
                                                    classProvider
                                                        .removeTextField(index);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 45.h,
                              width: double.infinity.w,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 60.w, right: 110.w),
                                child: TextButton(
                                    onPressed: () =>
                                        _submitStudentForm(context),
                                    style: ButtonStyle(
                                        shape: const WidgetStatePropertyAll(
                                            LinearBorder.none),
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 25, 74, 159))),
                                    child: Text('Add',
                                        style: TextStyle(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
