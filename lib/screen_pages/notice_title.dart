// import 'dart:developer';

// import 'package:fec_app2/providers/checkbox_provider.dart';
// import 'package:fec_app2/providers/date_time_provider.dart';
// import 'package:fec_app2/providers/dropdown_provider.dart';
// import 'package:fec_app2/providers/file_picker_provider.dart';
// import 'package:fec_app2/providers/formdata_submission.dart';
// import 'package:fec_app2/providers/initial_textformfield_provider.dart';
// import 'package:fec_app2/providers/profile_provider.dart';
// import 'package:fec_app2/providers/radiogroup_provider.dart';
// import 'package:fec_app2/screen_pages/notices.dart';
// // Removed pdfviewer import as it's no longer used after removing HtmlWidget
// import 'package:fec_app2/services.dart/push_notifications/notification_service.dart';
// import 'package:fec_app2/widgets/curved_botton.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// // Removed flutter_widget_from_html import due to App Store compliance
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class NoticeTitle extends StatefulWidget {
//   final String? mid;
//   final String? mtype;
//   final int? id;
//   final Map<String, dynamic>? newNotice;

//   const NoticeTitle({super.key, this.mid, this.mtype, this.id, this.newNotice});

//   @override
//   State<NoticeTitle> createState() => _NoticeTitleState();
// }

// class _NoticeTitleState extends State<NoticeTitle> {
//   final _formKey = GlobalKey<FormState>();

//   DateFormat dateFormat = DateFormat("dd-MM-yyyy");
//   void _submitFormData(BuildContext context, String? formId) async {
//     bool isvalid = _formKey.currentState!.validate();
//     FocusScope.of(context).unfocus();
//     if (!isvalid) {
//       return;
//     }
//     _formKey.currentState!.save();
//     Provider.of<FormDataSubmissionProvider>(context, listen: false)
//         .submissionFormData(
//       context,
//       formId,
//       Provider.of<InitialTextformfieldProvider>(context, listen: false)
//           .initializeTextController,
//       Provider.of<InitialTextformfieldProvider>(context, listen: false)
//           .initializeDateController,
//       Provider.of<InitialTextformfieldProvider>(context, listen: false)
//           .initializeNumController,
//       Provider.of<InitialTextformfieldProvider>(context, listen: false)
//           .initializeFileController,
//       Provider.of<CheckBoxProvider>(context, listen: false)
//           .selectedCheckboxValues,
//       Provider.of<DropDownProvider>(context, listen: false).selectedDropValues,
//       Provider.of<RadioGroupProvider>(context, listen: false)
//           .selectedRadioValue,
//       Provider.of<InitialTextformfieldProvider>(context, listen: false)
//           .initializeTextAreaController,
//     );
//   }

//   final PushNotificationServices _pushNotificationServices =
//       PushNotificationServices();
//   ProfileProvider profileProvider = ProfileProvider();

//   @override
//   void initState() {

//     log('AAAAAAAAAA notice title initState : ${widget.id}');
//     log('AAAAAAAAAA notice title initState : ${widget.newNotice}');

//     _pushNotificationServices.requestForNotificationPermissions();
//     _pushNotificationServices.getDeviceToken().then((value) {
//       if (kDebugMode) {
//         print('===========> \n $value');
//       }
//     });
//     profileProvider.getCurrentUser();
//     _pushNotificationServices.notificationInit(context);
//     _pushNotificationServices.getDeviceTokenRefreshing(context);
//     _pushNotificationServices.setUpMessageInteraction(context);

//     getInitailizeProvider();
//     super.initState();
//   }

//   void getInitailizeProvider() async {
//     Provider.of<CheckBoxProvider>(context, listen: false)
//         .apiAccessCheckBoxes(widget.id);
//     Provider.of<DropDownProvider>(context, listen: false)
//         .apiAccessDropDown(widget.id);
//     Provider.of<RadioGroupProvider>(context, listen: false)
//         .apiAccessRadioGroupes(widget.id);
//     Provider.of<InitialTextformfieldProvider>(context, listen: false)
//         .getCurrentNoticeWithProvider(widget.id);
//     Provider.of<InitialTextformfieldProvider>(context, listen: false)
//         .initializationControllers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("mid: ${widget.mid}     id: ${widget.id}   mtype: ${widget.mtype}    new notice : ${widget.newNotice.toString()}", );
//     Provider.of<InitialTextformfieldProvider>(context);
//     Provider.of<FilePickerProvider>(context);
//     Provider.of<DateTimeProvider>(context);
//     Provider.of<CheckBoxProvider>(context);
//     Provider.of<DropDownProvider>(context);
//     Provider.of<RadioGroupProvider>(context);

//     return SafeArea(
//         child: Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: const Color.fromARGB(255, 25, 74, 159),
//         flexibleSpace: ListTile(
//           contentPadding: const EdgeInsets.all(0),
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.restorablePopAndPushNamed(
//                     context, NoticesScreen.routeName);
//               },
//               icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
//           title: Text(
//             (widget.newNotice!["title"] == null ||
//                     widget.newNotice!["title"] == "")
//                 ? "No Notice's Title"
//                 : widget.newNotice!["title"].toString(),
//             style: TextStyle(color: Colors.white, fontSize: 14.sp),
//           ),
//           subtitle: Text(
//             (widget.newNotice!["created_at"] == null ||
//                     widget.newNotice!["created_at"] == "")
//                 ? "No DateTime"
//                 : DateFormat('dd-MM-yyyy - HH:mm').format(DateTime.tryParse(
//                     widget.newNotice!["created_at"]!.toString())!),
//             style: TextStyle(color: Colors.white, fontSize: 10.sp),
//           ),
//         ),
//         actions: [
//           Container(
//               width: 70.w,
//               decoration: const BoxDecoration(color: Colors.transparent),
//               child: Image.asset('assets/images/feclogos.png'))
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) => SingleChildScrollView(
//           child: Column(
//             children: [
//               ClipPath(
//                 clipper: StraightBorderClipper(borderWidth: 0),
//                 child: Container(
//                   height: 10.h,
//                   width: double.infinity.w,
//                   color: Colors.amber,
//                 ),
//               ),
//               SizedBox(height: 10.h),
//               Column(
//                 children: [
//                   Container(
//                       decoration: BoxDecoration(
//                           color: Colors.grey.shade200,
//                           shape: BoxShape.rectangle,
//                           borderRadius: BorderRadius.circular(10.r)),
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 20.w),
//                         child: Text(
//                           '''${(widget.newNotice!["description"] == null || widget.newNotice!["description"] == "") ? "No Description for such Notice" : widget.newNotice!["description"]}''',
//                           style: TextStyle(fontSize: 16.sp),
//                         ),
//                       )),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
//                 child: Consumer<InitialTextformfieldProvider>(
//                   builder: (context, initProvider, child) => Column(children: [
//                     initProvider.isloading == false
//                         ? const Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                           )
//                         : initProvider.particularForm!.isEmpty
//                             ? const Center(child: Text("Something went wrong"))
//                             : ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemCount: initProvider.particularForm!.length,
//                                 itemBuilder: (context, index) {
                                 
//                                   List<dynamic>? singleInitForm =
//                                       initProvider.particularForm![index]
//                                               ["form_data"] ??
//                                           [];
//                                    print("Total  Numbers ===  ${singleInitForm} ");

//                                   return Form(
//                                     key: _formKey,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             for (int i = 0;
//                                                 i < singleInitForm!.length;
//                                                 i++)
//                                               if (singleInitForm[i]["type"] ==
//                                                   "text")
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(3.0),
//                                                   child: TextFormField(
//                                                     key: Key(
//                                                         "${singleInitForm[i]["name"]}_$index"),
//                                                     controller: initProvider
//                                                         .getInitailizerTextController(
//                                                             singleInitForm[i]
//                                                                 ["name"]),
//                                                     keyboardType:
//                                                         TextInputType.text,
//                                                     textInputAction:
//                                                         TextInputAction.next,
//                                                     decoration: InputDecoration(
//                                                         enabled: true,
//                                                         border:
//                                                             const UnderlineInputBorder(
//                                                                 borderSide:
//                                                                     BorderSide
//                                                                         .none),
//                                                         enabledBorder:
//                                                             OutlineInputBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       10.r),
//                                                         ),
//                                                         focusedBorder:
//                                                             OutlineInputBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       10.r),
//                                                         ),
//                                                         label: Text(
//                                                             singleInitForm[i]
//                                                                 ["label"]),
//                                                         fillColor: Colors.white,
//                                                         filled: true,
//                                                         contentPadding:
//                                                             const EdgeInsets
//                                                                 .all(8)),
//                                                     onChanged: (value) {},
//                                                   ),
//                                                 ),
//                                           ],
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             for (int j = 0;
//                                                 j < singleInitForm.length;
//                                                 j++)
//                                               if (singleInitForm[j]["type"] ==
//                                                   "date")
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(3.0),
//                                                   child: Consumer<
//                                                       DateTimeProvider>(
//                                                     builder:
//                                                         (context, dp, child) =>
//                                                             TextFormField(
//                                                       key: Key(
//                                                           "${singleInitForm[j]["name"]}_$index"),
//                                                       controller: initProvider
//                                                           .getInitailizerDateController(
//                                                               singleInitForm[j]
//                                                                   ["name"]),
//                                                       keyboardType:
//                                                           TextInputType
//                                                               .datetime,
//                                                       readOnly: true,
//                                                       textInputAction:
//                                                           TextInputAction.next,
//                                                       decoration:
//                                                           InputDecoration(
//                                                               enabled: true,
//                                                               border: const UnderlineInputBorder(
//                                                                   borderSide:
//                                                                       BorderSide
//                                                                           .none),
//                                                               enabledBorder:
//                                                                   OutlineInputBorder(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             10.r),
//                                                               ),
//                                                               focusedBorder:
//                                                                   OutlineInputBorder(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             10.r),
//                                                               ),
//                                                               label: Text(
//                                                                   singleInitForm[
//                                                                           j][
//                                                                       "label"]),
//                                                               fillColor:
//                                                                   Colors.white,
//                                                               filled: true,
//                                                               contentPadding:
//                                                                   const EdgeInsets
//                                                                       .all(8)),
//                                                       onTap: () async {
//                                                         initProvider
//                                                                 .getInitailizerDateController(
//                                                                     singleInitForm[j]
//                                                                         ["name"])!
//                                                                 .text =
//                                                             await dp
//                                                                 .dateTimePicker(
//                                                                     context);
//                                                       },
//                                                     ),
//                                                   ),
//                                                 ),
//                                           ],
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             for (int k = 0;
//                                                 k < singleInitForm.length;
//                                                 k++)
//                                               if (singleInitForm[k]["type"] ==
//                                                   "number")
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(3.0),
//                                                   child: TextFormField(
//                                                     key: Key(
//                                                         "${singleInitForm[k]["name"]}_$index"),
//                                                     controller: initProvider
//                                                         .getInitailizerNumController(
//                                                             singleInitForm[k]
//                                                                 ["name"]),
//                                                     textInputAction:
//                                                         TextInputAction.next,
//                                                     keyboardType:
//                                                         TextInputType.number,
//                                                     decoration: InputDecoration(
//                                                         enabled: true,
//                                                         enabledBorder:
//                                                             const OutlineInputBorder(
//                                                                 borderRadius: BorderRadius
//                                                                     .all(Radius
//                                                                         .circular(
//                                                                             10))),
//                                                         focusedBorder:
//                                                             OutlineInputBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       10.r),
//                                                         ),
//                                                         border:
//                                                             const UnderlineInputBorder(
//                                                                 borderSide:
//                                                                     BorderSide
//                                                                         .none),
//                                                         label: Text(
//                                                             singleInitForm[k]
//                                                                 ["label"]),
//                                                         fillColor: Colors.white,
//                                                         filled: true,
//                                                         contentPadding:
//                                                             const EdgeInsets
//                                                                 .all(8)),
//                                                     onChanged: (value) {},
//                                                   ),
//                                                 ),
//                                           ],
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             for (int l = 0;
//                                                 l < singleInitForm.length;
//                                                 l++)
//                                               if (singleInitForm[l]["type"] ==
//                                                   "file")
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(3.0),
//                                                   child: Consumer<
//                                                       FilePickerProvider>(
//                                                     builder:
//                                                         (context, fpp, child) =>
//                                                             TextFormField(
//                                                       key: Key(
//                                                           "${singleInitForm[l]["name"]}_$index"),
//                                                       controller: initProvider
//                                                           .getInitailizerFileController(
//                                                               singleInitForm[l]
//                                                                   ["name"]),
//                                                       textInputAction:
//                                                           TextInputAction.next,
//                                                       readOnly: true,
//                                                       decoration:
//                                                           InputDecoration(
//                                                               enabled: true,
//                                                               border: const UnderlineInputBorder(
//                                                                   borderSide:
//                                                                       BorderSide
//                                                                           .none),
//                                                               enabledBorder:
//                                                                   OutlineInputBorder(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             10.r),
//                                                               ),
//                                                               focusedBorder:
//                                                                   OutlineInputBorder(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             10.r),
//                                                               ),
//                                                               label: Text(
//                                                                   singleInitForm[
//                                                                           l][
//                                                                       "label"]),
//                                                               fillColor:
//                                                                   Colors.white,
//                                                               filled: true,
//                                                               contentPadding:
//                                                                   const EdgeInsets
//                                                                       .all(8)),
//                                                       onTap: () async {
//                                                         initProvider
//                                                                 .getInitailizerFileController(
//                                                                     singleInitForm[l]
//                                                                         ["name"])!
//                                                                 .text =
//                                                             await fpp
//                                                                 .filePickerFromGallery(
//                                                                     context);
//                                                       },
//                                                     ),
//                                                   ),
//                                                 ),
//                                           ],
//                                         ),
//                                         Consumer<CheckBoxProvider>(
//                                           builder:
//                                               (context, checkBoxPro, child) =>
//                                                   Column(
//                                             children: [
//                                               for (int l = 0;
//                                                   l < singleInitForm.length;
//                                                   l++)
//                                                 if (singleInitForm[l]["type"] ==
//                                                     "checkbox-group")
//                                                   for (var option
//                                                       in (singleInitForm[l]
//                                                           ["values"] as List))
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               3.0),
//                                                       child: Container(
//                                                         decoration: BoxDecoration(
//                                                             borderRadius:
//                                                                 BorderRadius.all(
//                                                                     Radius.circular(
//                                                                         10.r)),
//                                                             border:
//                                                                 Border.all()),
//                                                         child: CheckboxListTile(
//                                                           activeColor:
//                                                               const Color
//                                                                   .fromARGB(255,
//                                                                   25, 74, 159),
//                                                           title: Text(
//                                                               option["label"]),
//                                                           value: checkBoxPro
//                                                               .getSelectUnselectCheckboxes(
//                                                                   singleInitForm[
//                                                                           l]
//                                                                       ["name"])
//                                                               .contains(option[
//                                                                   "value"]),
//                                                           onChanged: (value) {
//                                                             checkBoxPro
//                                                                 .selectUnselectCheckboxes(
//                                                                     value,
//                                                                     option[
//                                                                         "value"],
//                                                                     singleInitForm[
//                                                                             l][
//                                                                         "name"]);
//                                                           },
//                                                         ),
//                                                       ),
//                                                     )
//                                             ],
//                                           ),
//                                         ),
//                                         Consumer<RadioGroupProvider>(
//                                           builder: (context, radioPro, child) =>
//                                               Column(
//                                             children: [
//                                               for (int l = 0;
//                                                   l < singleInitForm.length;
//                                                   l++)
//                                                 if (singleInitForm[l]["type"] ==
//                                                     "radio-group")
//                                                   for (var option
//                                                       in (singleInitForm[l]
//                                                           ["values"] as List))
//                                                     Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(3.0),
//                                                         child: Container(
//                                                           margin: EdgeInsets
//                                                               .symmetric(
//                                                                   vertical:
//                                                                       4.h),
//                                                           height: 50.h,
//                                                           decoration: BoxDecoration(
//                                                               borderRadius: BorderRadius
//                                                                   .all(Radius
//                                                                       .circular(10
//                                                                           .r)),
//                                                               border:
//                                                                   Border.all()),
//                                                           child: RadioListTile(
//                                                             activeColor:
//                                                                 const Color
//                                                                     .fromARGB(
//                                                                     255,
//                                                                     25,
//                                                                     74,
//                                                                     159),
//                                                             title: Text(option[
//                                                                 "label"]),
//                                                             value:
//                                                                 option["value"],
//                                                             groupValue: radioPro
//                                                                 .getSelectedValue(
//                                                                     singleInitForm[
//                                                                             l][
//                                                                         "name"]),
//                                                             onChanged: (value) {
//                                                               radioPro.updateSelectedValue(
//                                                                   value,
//                                                                   singleInitForm[
//                                                                           l]
//                                                                       ["name"]);
//                                                             },
//                                                           ),
//                                                         ))
//                                             ],
//                                           ),
//                                         ),
//                                         Consumer<DropDownProvider>(
//                                           builder:
//                                               (context, dropDownPro, child) =>
//                                                   Column(
//                                             children: [
//                                               for (int l = 0;
//                                                   l < singleInitForm.length;
//                                                   l++)
//                                                 if (singleInitForm[l]["type"] ==
//                                                     "select")
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             3.0),
//                                                     child: Container(
//                                                       margin:
//                                                           EdgeInsets.symmetric(
//                                                               vertical: 4.h),
//                                                       height: 50.h,
//                                                       decoration: BoxDecoration(
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                                   Radius
//                                                                       .circular(
//                                                                           10.r)),
//                                                           border: Border.all()),
//                                                       child: Padding(
//                                                         padding: EdgeInsets
//                                                             .symmetric(
//                                                                 horizontal:
//                                                                     10.w,
//                                                                 vertical: 2.h),
//                                                         child:
//                                                             DropdownButtonFormField<
//                                                                 String>(
//                                                           decoration: const InputDecoration(
//                                                               border: UnderlineInputBorder(
//                                                                   borderSide:
//                                                                       BorderSide
//                                                                           .none)),
//                                                           value: dropDownPro
//                                                               .getSelectOneDropDown(
//                                                                   singleInitForm[
//                                                                           l]
//                                                                       ["name"]),
//                                                           items: (singleInitForm[
//                                                                           l]
//                                                                       ["values"]
//                                                                   as List)
//                                                               .map<
//                                                                   DropdownMenuItem<
//                                                                       String>>((e) {
//                                                             return DropdownMenuItem<
//                                                                 String>(
//                                                               value: e["value"],
//                                                               child: Text(
//                                                                   e["label"]),
//                                                             );
//                                                           }).toList(),
//                                                           onChanged: (value) {
//                                                             dropDownPro
//                                                                 .selectOneDropDown(
//                                                                     singleInitForm[
//                                                                             l][
//                                                                         "name"],
//                                                                     value!);
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                             ],
//                                           ),
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             for (int l = 0;
//                                                 l < singleInitForm.length;
//                                                 l++)
//                                               if (singleInitForm[l]["type"] ==
//                                                   "textarea")
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(3.0),
//                                                   child: TextFormField(
//                                                     maxLines: 50,
//                                                     minLines: 3,
//                                                     key: Key(
//                                                         "${singleInitForm[l]["name"]}_$index"),
//                                                     controller: initProvider
//                                                         .getInitailizerTextAreaController(
//                                                             singleInitForm[l]
//                                                                 ["name"]),
//                                                     textInputAction:
//                                                         TextInputAction.next,
//                                                     keyboardType:
//                                                         TextInputType.multiline,
//                                                     decoration: InputDecoration(
//                                                         enabled: true,
//                                                         border:
//                                                             const UnderlineInputBorder(
//                                                                 borderSide:
//                                                                     BorderSide
//                                                                         .none),
//                                                         enabledBorder:
//                                                             OutlineInputBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       10.r),
//                                                         ),
//                                                         focusedBorder:
//                                                             OutlineInputBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       10.r),
//                                                         ),
//                                                         label: Text(
//                                                             singleInitForm[l]
//                                                                 ["label"]),
//                                                         fillColor: Colors.white,
//                                                         filled: true,
//                                                         contentPadding:
//                                                             const EdgeInsets
//                                                                 .all(8)),
//                                                     onChanged: (value) {},
//                                                   ),
//                                                 ),
//                                           ],
//                                         ),
//                                         for (int l = 0;
//                                             l < singleInitForm.length;
//                                             l++)
//                                           if (singleInitForm[l]["type"]
//                                                       .toString()
//                                                       .toLowerCase() ==
//                                                   "button" &&
//                                               singleInitForm[l]["subtype"]
//                                                       .toString()
//                                                       .toLowerCase() ==
//                                                   "submit")
//                                             Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(3.0),
//                                                 child: SizedBox(
//                                                   height: 45.h,
//                                                   width: double.infinity,
//                                                   child: ElevatedButton(
//                                                       style: const ButtonStyle(
//                                                           shape: WidgetStatePropertyAll(
//                                                               RoundedRectangleBorder(
//                                                                   side: BorderSide
//                                                                       .none)),
//                                                           backgroundColor:
//                                                               WidgetStatePropertyAll(
//                                                                   Color.fromARGB(
//                                                                       255,
//                                                                       25,
//                                                                       74,
//                                                                       159))),
//                                                       onPressed: () {
//                                                         _submitFormData(
//                                                             context,
//                                                             initProvider
//                                                                     .particularForm![
//                                                                 index]["form_id"]);
//                                                       },
//                                                       child: Text(
//                                                         singleInitForm[l]
//                                                                 ["type"]
//                                                             .toString(),
//                                                         style: const TextStyle(
//                                                             color:
//                                                                 Colors.white),
//                                                       )),
//                                                 ))
//                                       ],
//                                     ),
//                                   );
//                                 }),
//                   ]),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }

import 'dart:async';
import 'dart:developer';
import 'package:fec_app2/providers/checkbox_provider.dart';
import 'package:fec_app2/providers/date_time_provider.dart';
import 'package:fec_app2/providers/dropdown_provider.dart';
import 'package:fec_app2/providers/file_picker_provider.dart';
import 'package:fec_app2/providers/formdata_submission.dart';
import 'package:fec_app2/providers/initial_textformfield_provider.dart';
import 'package:fec_app2/providers/profile_provider.dart';
import 'package:fec_app2/providers/radiogroup_provider.dart';
import 'package:fec_app2/screen_pages/notices.dart';
import 'package:fec_app2/screen_pages/pdfviewer.dart';
import 'package:fec_app2/services.dart/push_notifications/notification_service.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticeTitle extends StatefulWidget {
  final String? mid;
  final String? mtype;
  final int? id;
  final Map<String, dynamic>? newNotice;

  const NoticeTitle({super.key, this.mid, this.mtype, this.id, this.newNotice});

  @override
  State<NoticeTitle> createState() => _NoticeTitleState();
}

class _NoticeTitleState extends State<NoticeTitle> {
  final _formKey = GlobalKey<FormState>();

  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  
  void _submitFormData(BuildContext context, String? formId) async {
    bool isvalid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isvalid) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<FormDataSubmissionProvider>(context, listen: false)
        .submissionFormData(
      context,
      formId,
      Provider.of<InitialTextformfieldProvider>(context, listen: false)
          .initializeTextController,
      Provider.of<InitialTextformfieldProvider>(context, listen: false)
          .initializeDateController,
      Provider.of<InitialTextformfieldProvider>(context, listen: false)
          .initializeNumController,
      Provider.of<InitialTextformfieldProvider>(context, listen: false)
          .initializeFileController,
      Provider.of<CheckBoxProvider>(context, listen: false)
          .selectedCheckboxValues,
      Provider.of<DropDownProvider>(context, listen: false).selectedDropValues,
      Provider.of<RadioGroupProvider>(context, listen: false)
          .selectedRadioValue,
      Provider.of<InitialTextformfieldProvider>(context, listen: false)
          .initializeTextAreaController,
    );
  }

  final PushNotificationServices _pushNotificationServices =
      PushNotificationServices();
  ProfileProvider profileProvider = ProfileProvider();

  @override
  void initState() {
    super.initState();
    
    try {
      log('AAAAAAAAAA notice title initState : ${widget.id}');
      log('AAAAAAAAAA notice title initState : ${widget.newNotice}');
    } catch (e) {
      if (kDebugMode) {
        print('Error in initState logging: $e');
      }
    }

    // Wrap Firebase operations in try-catch to prevent crashes
    try {
      _pushNotificationServices.requestForNotificationPermissions();
    } catch (e) {
      if (kDebugMode) {
        print('Error requesting notification permissions: $e');
      }
    }

    try {
      _pushNotificationServices.getDeviceToken().then((value) {
        if (kDebugMode && value != null) {
          print('===========> \n $value');
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('Error getting device token: $error');
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error in getDeviceToken: $e');
      }
    }

    try {
      profileProvider.getCurrentUser();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting current user: $e');
      }
    }

    try {
      _pushNotificationServices.notificationInit(context);
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing notifications: $e');
      }
    }

    try {
      _pushNotificationServices.getDeviceTokenRefreshing(context);
    } catch (e) {
      if (kDebugMode) {
        print('Error refreshing device token: $e');
      }
    }

    try {
      _pushNotificationServices.setUpMessageInteraction(context);
    } catch (e) {
      if (kDebugMode) {
        print('Error setting up message interaction: $e');
      }
    }

    try {
      getInitailizeProvider();
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing providers: $e');
      }
    }
  }

  void getInitailizeProvider() async {
    Provider.of<CheckBoxProvider>(context, listen: false)
        .apiAccessCheckBoxes(widget.id);
    Provider.of<DropDownProvider>(context, listen: false)
        .apiAccessDropDown(widget.id);
    Provider.of<RadioGroupProvider>(context, listen: false)
        .apiAccessRadioGroupes(widget.id);
    Provider.of<InitialTextformfieldProvider>(context, listen: false)
        .getCurrentNoticeWithProvider(widget.id);
    Provider.of<InitialTextformfieldProvider>(context, listen: false)
        .initializationControllers();
  }

  String _getTitleText() {
    if (widget.newNotice == null) {
      return "No Notice's Title";
    }
    
    try {
      final title = widget.newNotice!["title"];
      if (title == null) {
        return "No Notice's Title";
      }
      
      final titleStr = title.toString();
      if (titleStr.isEmpty || titleStr == "null") {
        return "No Notice's Title";
      }
      return titleStr;
    } catch (e) {
      if (kDebugMode) {
        print('Error converting title to string: $e');
      }
      return "No Notice's Title";
    }
  }

  String _getCreatedAtText() {
    if (widget.newNotice == null) {
      return "No DateTime";
    }
    
    try {
      final createdAt = widget.newNotice!["created_at"];
      if (createdAt == null) {
        return "No DateTime";
      }
      
      final createdAtStr = createdAt.toString();
      if (createdAtStr.isEmpty || createdAtStr == "null") {
        return "No DateTime";
      }
      
      final parsedDate = DateTime.tryParse(createdAtStr);
      if (parsedDate == null) {
        return "No DateTime";
      }
      
      return DateFormat('dd-MM-yyyy - HH:mm').format(parsedDate);
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing created_at: $e');
      }
      return "No DateTime";
    }
  }

  String _getDescriptionText() {
    if (widget.newNotice == null) {
      return "No Description for such Notice";
    }
    
    try {
      final description = widget.newNotice!["description"];
      if (description == null) {
        return "No Description for such Notice";
      }
      
      // Safely convert to string
      final descriptionStr = description.toString();
      if (descriptionStr.isEmpty || descriptionStr == "null") {
        return "No Description for such Notice";
      }
      
      // Remove PDF links from description
      return _removePdfLinks(descriptionStr);
    } catch (e) {
      if (kDebugMode) {
        print('Error converting description to string: $e');
      }
      return "No Description for such Notice";
    }
  }

  /// Removes PDF anchor tags from HTML description
  String _removePdfLinks(String html) {
    try {
      // Remove anchor tags that link to PDF files
      String cleaned = html;
      
      // Pattern to match anchor tags with PDF links (double quotes)
      cleaned = cleaned.replaceAll(
        RegExp(r'<a\s+[^>]*href\s*=\s*"[^"]*\.pdf[^"]*"[^>]*>.*?</a>', caseSensitive: false, dotAll: true),
        '',
      );
      
      // Pattern to match anchor tags with PDF links (single quotes)
      cleaned = cleaned.replaceAll(
        RegExp(r"<a\s+[^>]*href\s*=\s*'[^']*\.pdf[^']*'[^>]*>.*?</a>", caseSensitive: false, dotAll: true),
        '',
      );
      
      return cleaned.trim();
    } catch (e) {
      if (kDebugMode) {
        print('Error removing PDF links: $e');
      }
      return html;
    }
  }

  /// Checks if description has meaningful content after removing PDF links
  bool _hasDescriptionContent() {
    if (widget.newNotice == null) {
      return false;
    }
    
    try {
      final description = widget.newNotice!["description"];
      if (description == null) {
        return false;
      }
      
      final descriptionStr = description.toString();
      if (descriptionStr.isEmpty || descriptionStr == "null") {
        return false;
      }
      
      // Remove PDF links first
      final withoutPdfLinks = _removePdfLinks(descriptionStr);
      
      // Check if there's actual text content after removing HTML tags
      final cleaned = withoutPdfLinks
          .replaceAll(RegExp(r'<[^>]*>'), '') // Remove all HTML tags
          .replaceAll('&nbsp;', ' ') // Replace &nbsp; with space
          .replaceAll('&amp;', '&') // Replace HTML entities
          .replaceAll(RegExp(r'\s+'), ' ') // Replace multiple spaces with single space
          .trim();
      
      return cleaned.isNotEmpty;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking description content: $e');
      }
      return false;
    }
  }

  /// Extracts PDF URL from description if it contains a PDF link
  String? _extractPdfUrl() {
    if (widget.newNotice == null) {
      return null;
    }
    
    try {
      final description = widget.newNotice!["description"];
      if (description == null) {
        return null;
      }
      
      final descriptionStr = description.toString();
      if (descriptionStr.isEmpty || descriptionStr == "null") {
        return null;
      }

      // Pattern to match anchor tags with PDF links
      final anchorPatternDouble = RegExp(
        r'<a\s+[^>]*href\s*=\s*"([^"]+\.pdf[^"]*)"[^>]*>',
        caseSensitive: false,
      );
      final anchorPatternSingle = RegExp(
        r"<a\s+[^>]*href\s*=\s*'([^']+\.pdf[^']*)'[^>]*>",
        caseSensitive: false,
      );

      // Try double quotes first
      final matchDouble = anchorPatternDouble.firstMatch(descriptionStr);
      if (matchDouble != null) {
        final href = matchDouble.group(1) ?? '';
        if (href.toLowerCase().endsWith('.pdf')) {
          return _resolvePdfUrl(href);
        }
      }

      // Try single quotes
      final matchSingle = anchorPatternSingle.firstMatch(descriptionStr);
      if (matchSingle != null) {
        final href = matchSingle.group(1) ?? '';
        if (href.toLowerCase().endsWith('.pdf')) {
          return _resolvePdfUrl(href);
        }
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error extracting PDF URL: $e');
      }
      return null;
    }
  }

  /// Resolves PDF URL to absolute URL
  String _resolvePdfUrl(String href) {
    if (href.isEmpty) return '';
    
    // If it's already an absolute URL, return as is
    if (href.startsWith('http://') || href.startsWith('https://')) {
      return href;
    }
    
    // Handle relative URLs
    String cleanPath = href;
    while (cleanPath.startsWith('../') || cleanPath.startsWith('./')) {
      if (cleanPath.startsWith('../')) {
        cleanPath = cleanPath.substring(3);
      } else if (cleanPath.startsWith('./')) {
        cleanPath = cleanPath.substring(2);
      }
    }
    
    const baseUrl = 'https://froebelapp.com';
    
    // If it starts with /, it's an absolute path on the server
    if (cleanPath.startsWith('/')) {
      return '$baseUrl$cleanPath';
    }
    
    // Otherwise, it's a relative path
    return '$baseUrl/$cleanPath';
  }

  /// Safely converts a value to string, handling null cases
  String _safeToString(dynamic value) {
    if (value == null) {
      return "";
    }
    try {
      return value.toString();
    } catch (e) {
      if (kDebugMode) {
        print('Error converting value to string: $e');
      }
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("mid: ${widget.mid}     id: ${widget.id}   mtype: ${widget.mtype}    new notice : ${widget.newNotice?.toString() ?? 'null'}");
    }
    Provider.of<InitialTextformfieldProvider>(context);
    Provider.of<FilePickerProvider>(context);
    Provider.of<DateTimeProvider>(context);
    Provider.of<CheckBoxProvider>(context);
    Provider.of<DropDownProvider>(context);
    Provider.of<RadioGroupProvider>(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 25, 74, 159),
        flexibleSpace: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: IconButton(
              onPressed: () {
                Navigator.restorablePopAndPushNamed(
                    context, NoticesScreen.routeName);
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
          title: Text(
            _getTitleText(),
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
          subtitle: Text(
            _getCreatedAtText(),
            style: TextStyle(color: Colors.white, fontSize: 10.sp),
          ),
        ),
        actions: [
          Container(
              width: 70.w,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Image.asset('assets/images/feclogos.png'))
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: StraightBorderClipper(borderWidth: 0),
                child: Container(
                  height: 10.h,
                  width: double.infinity.w,
                  color: Colors.amber,
                ),
              ),
              SizedBox(height: 10.h),
              Builder(
                builder: (context) {
                  final hasContent = _hasDescriptionContent();
                  final pdfUrl = _extractPdfUrl();
                  
                  // If no content and no PDF, don't show anything
                  if (!hasContent && pdfUrl == null) {
                    return const SizedBox.shrink();
                  }
                  
                  return Column(
                    children: [
                      // Description content - only show if there's actual content
                      if (hasContent)
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                              child: HtmlRenderer(
                                htmlContent: _getDescriptionText(),
                                defaultTextStyle: TextStyle(fontSize: 16.sp, color: Colors.black87),
                                context: context,
                              ),
                            )),
                      // PDF viewer below description if PDF exists
                      if (pdfUrl != null)
                        Padding(
                          padding: EdgeInsets.only(top: hasContent ? 15.h : 0),
                          child: Container(
                            height: 500.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: _EmbeddedPdfViewer(pdfUrl: pdfUrl),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                child: Consumer<InitialTextformfieldProvider>(
                  builder: (context, initProvider, child) => Column(children: [
                    initProvider.isloading == false
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : initProvider.particularForm!.isEmpty
                            ? const Center(child: Text(""))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: initProvider.particularForm!.length,
                                itemBuilder: (context, index) {
                                 
                                  List<dynamic>? singleInitForm =
                                      initProvider.particularForm![index]
                                              ["form_data"] ??
                                          [];
                                   print("Total  Numbers ===  ${singleInitForm} ");

                                  return Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (int i = 0;
                                                i < singleInitForm!.length;
                                                i++)
                                              if (singleInitForm[i]["type"] ==
                                                  "text")
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: TextFormField(
                                                    key: Key(
                                                        "${singleInitForm[i]["name"]}_$index"),
                                                    controller: initProvider
                                                        .getInitailizerTextController(
                                                            singleInitForm[i]
                                                                ["name"]),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: InputDecoration(
                                                        enabled: true,
                                                        border:
                                                            const UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                        ),
                                                        label: Text(
                                                            singleInitForm[i]
                                                                ["label"]),
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(8)),
                                                    onChanged: (value) {},
                                                  ),
                                                ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (int j = 0;
                                                j < singleInitForm.length;
                                                j++)
                                              if (singleInitForm[j]["type"] ==
                                                  "date")
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Consumer<
                                                      DateTimeProvider>(
                                                    builder:
                                                        (context, dp, child) =>
                                                            TextFormField(
                                                      key: Key(
                                                          "${singleInitForm[j]["name"]}_$index"),
                                                      controller: initProvider
                                                          .getInitailizerDateController(
                                                              singleInitForm[j]
                                                                  ["name"]),
                                                      keyboardType:
                                                          TextInputType
                                                              .datetime,
                                                      readOnly: true,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          InputDecoration(
                                                              enabled: true,
                                                              border: const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.r),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.r),
                                                              ),
                                                              label: Text(
                                                                  singleInitForm[
                                                                          j][
                                                                      "label"]),
                                                              fillColor:
                                                                  Colors.white,
                                                              filled: true,
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .all(8)),
                                                      onTap: () async {
                                                        initProvider
                                                                .getInitailizerDateController(
                                                                    singleInitForm[j]
                                                                        ["name"])!
                                                                .text =
                                                            await dp
                                                                .dateTimePicker(
                                                                    context);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (int k = 0;
                                                k < singleInitForm.length;
                                                k++)
                                              if (singleInitForm[k]["type"] ==
                                                  "number")
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: TextFormField(
                                                    key: Key(
                                                        "${singleInitForm[k]["name"]}_$index"),
                                                    controller: initProvider
                                                        .getInitailizerNumController(
                                                            singleInitForm[k]
                                                                ["name"]),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                        enabled: true,
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                        ),
                                                        border:
                                                            const UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                        label: Text(
                                                            singleInitForm[k]
                                                                ["label"]),
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(8)),
                                                    onChanged: (value) {},
                                                  ),
                                                ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (int l = 0;
                                                l < singleInitForm.length;
                                                l++)
                                              if (singleInitForm[l]["type"] ==
                                                  "file")
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Consumer<
                                                      FilePickerProvider>(
                                                    builder:
                                                        (context, fpp, child) =>
                                                            TextFormField(
                                                      key: Key(
                                                          "${singleInitForm[l]["name"]}_$index"),
                                                      controller: initProvider
                                                          .getInitailizerFileController(
                                                              singleInitForm[l]
                                                                  ["name"]),
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      readOnly: true,
                                                      decoration:
                                                          InputDecoration(
                                                              enabled: true,
                                                              border: const UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.r),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.r),
                                                              ),
                                                              label: Text(
                                                                  singleInitForm[
                                                                          l][
                                                                      "label"]),
                                                              fillColor:
                                                                  Colors.white,
                                                              filled: true,
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .all(8)),
                                                      onTap: () async {
                                                        initProvider
                                                                .getInitailizerFileController(
                                                                    singleInitForm[l]
                                                                        ["name"])!
                                                                .text =
                                                            await fpp
                                                                .filePickerFromGallery(
                                                                    context);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                          ],
                                        ),
                                        Consumer<CheckBoxProvider>(
                                          builder:
                                              (context, checkBoxPro, child) =>
                                                  Column(
                                            children: [
                                              for (int l = 0;
                                                  l < singleInitForm.length;
                                                  l++)
                                                if (singleInitForm[l]["type"] ==
                                                    "checkbox-group")
                                                  for (var option
                                                      in (singleInitForm[l]
                                                          ["values"] as List))
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10.r)),
                                                            border:
                                                                Border.all()),
                                                        child: CheckboxListTile(
                                                          activeColor:
                                                              const Color
                                                                  .fromARGB(255,
                                                                  25, 74, 159),
                                                          title: Text(
                                                              option["label"]),
                                                          value: checkBoxPro
                                                              .getSelectUnselectCheckboxes(
                                                                  singleInitForm[
                                                                          l]
                                                                      ["name"])
                                                              .contains(option[
                                                                  "value"]),
                                                          onChanged: (value) {
                                                            checkBoxPro
                                                                .selectUnselectCheckboxes(
                                                                    value,
                                                                    option[
                                                                        "value"],
                                                                    singleInitForm[
                                                                            l][
                                                                        "name"]);
                                                          },
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ),
                                        Consumer<RadioGroupProvider>(
                                          builder: (context, radioPro, child) =>
                                              Column(
                                            children: [
                                              for (int l = 0;
                                                  l < singleInitForm.length;
                                                  l++)
                                                if (singleInitForm[l]["type"] ==
                                                    "radio-group")
                                                  for (var option
                                                      in (singleInitForm[l]
                                                          ["values"] as List))
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      4.h),
                                                          height: 50.h,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(10
                                                                          .r)),
                                                              border:
                                                                  Border.all()),
                                                          child: RadioListTile(
                                                            activeColor:
                                                                const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    25,
                                                                    74,
                                                                    159),
                                                            title: Text(option[
                                                                "label"]),
                                                            value:
                                                                option["value"],
                                                            groupValue: radioPro
                                                                .getSelectedValue(
                                                                    singleInitForm[
                                                                            l][
                                                                        "name"]),
                                                            onChanged: (value) {
                                                              radioPro.updateSelectedValue(
                                                                  value,
                                                                  singleInitForm[
                                                                          l]
                                                                      ["name"]);
                                                            },
                                                          ),
                                                        ))
                                            ],
                                          ),
                                        ),
                                        Consumer<DropDownProvider>(
                                          builder:
                                              (context, dropDownPro, child) =>
                                                  Column(
                                            children: [
                                              for (int l = 0;
                                                  l < singleInitForm.length;
                                                  l++)
                                                if (singleInitForm[l]["type"] ==
                                                    "select")
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 4.h),
                                                      height: 50.h,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10.r)),
                                                          border: Border.all()),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.w,
                                                                vertical: 2.h),
                                                        child:
                                                            DropdownButtonFormField<
                                                                String>(
                                                          decoration: const InputDecoration(
                                                              border: UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none)),
                                                          value: dropDownPro
                                                              .getSelectOneDropDown(
                                                                  singleInitForm[
                                                                          l]
                                                                      ["name"]),
                                                          items: (singleInitForm[
                                                                          l]
                                                                      ["values"]
                                                                  as List)
                                                              .map<
                                                                  DropdownMenuItem<
                                                                      String>>((e) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: e["value"],
                                                              child: Text(
                                                                  e["label"]),
                                                            );
                                                          }).toList(),
                                                          onChanged: (value) {
                                                            dropDownPro
                                                                .selectOneDropDown(
                                                                    singleInitForm[
                                                                            l][
                                                                        "name"],
                                                                    value!);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (int l = 0;
                                                l < singleInitForm.length;
                                                l++)
                                              if (singleInitForm[l]["type"] ==
                                                  "textarea")
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: TextFormField(
                                                    maxLines: 50,
                                                    minLines: 3,
                                                    key: Key(
                                                        "${singleInitForm[l]["name"]}_$index"),
                                                    controller: initProvider
                                                        .getInitailizerTextAreaController(
                                                            singleInitForm[l]
                                                                ["name"]),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    decoration: InputDecoration(
                                                        enabled: true,
                                                        border:
                                                            const UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                        ),
                                                        label: Text(
                                                            singleInitForm[l]
                                                                ["label"]),
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(8)),
                                                    onChanged: (value) {},
                                                  ),
                                                ),
                                          ],
                                        ),
                                        for (int l = 0;
                                            l < singleInitForm.length;
                                            l++)
                                          if (_safeToString(singleInitForm[l]["type"])
                                                      .toLowerCase() ==
                                                  "button" &&
                                              _safeToString(singleInitForm[l]["subtype"])
                                                      .toLowerCase() ==
                                                  "submit")
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: SizedBox(
                                                  height: 45.h,
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                      style: const ButtonStyle(
                                                          shape: WidgetStatePropertyAll(
                                                              RoundedRectangleBorder(
                                                                  side: BorderSide
                                                                      .none)),
                                                          backgroundColor:
                                                              WidgetStatePropertyAll(
                                                                  Color.fromARGB(
                                                                      255,
                                                                      25,
                                                                      74,
                                                                      159))),
                                                      onPressed: () {
                                                        final formId = initProvider
                                                                .particularForm![index]["form_id"];
                                                        _submitFormData(
                                                            context,
                                                            formId?.toString());
                                                      },
                                                      child: Text(
                                                        _safeToString(singleInitForm[l]["type"]),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                ))
                                      ],
                                    ),
                                  );
                                }),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

/// A widget that renders HTML content safely for iOS
/// Parses common HTML tags and converts them to Flutter widgets
class HtmlRenderer extends StatelessWidget {
  final String htmlContent;
  final TextStyle? defaultTextStyle;
  final BuildContext context;

  const HtmlRenderer({
    Key? key,
    required this.htmlContent,
    required this.context,
    this.defaultTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parser = SimpleHtmlParser(htmlContent, context);
    final widgets = parser.parseToWidgets(
      defaultTextStyle ?? TextStyle(fontSize: 14.sp, color: Colors.black),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}

// Helper classes and enums for HTML parsing
enum _TagType { anchor, inline }

class _TagMatch {
  final int start;
  final int end;
  final _TagType type;
  final String tag;
  final String href;
  final String content;

  _TagMatch({
    required this.start,
    required this.end,
    required this.type,
    this.tag = '',
    this.href = '',
    this.content = '',
  });
}

/// Simple HTML parser that converts HTML to Flutter widgets
class SimpleHtmlParser {
  final String html;
  final BuildContext context;
  static const String baseUrl = 'https://froebelapp.com';

  SimpleHtmlParser(this.html, this.context);

  List<Widget> parseToWidgets(TextStyle defaultStyle) {
    final List<Widget> widgets = [];
    
    // Remove extra whitespace and newlines
    String cleanHtml = html.trim();
    
    // If empty, return empty list
    if (cleanHtml.isEmpty) {
      return widgets;
    }

    // Split by common block elements
    final blockElements = _splitByBlockElements(cleanHtml);
    
    for (var block in blockElements) {
      final widget = _parseBlock(block, defaultStyle);
      if (widget != null) {
        widgets.add(widget);
        widgets.add(SizedBox(height: 8.h)); // Spacing between blocks
      }
    }

    // Remove last spacing
    if (widgets.isNotEmpty && widgets.last is SizedBox) {
      widgets.removeLast();
    }

    return widgets;
  }

  List<String> _splitByBlockElements(String html) {
    final List<String> blocks = [];
    
    // Simple split by closing tags
    final pattern = RegExp(r'</(p|div|h[1-6]|li|br)>', caseSensitive: false);
    final parts = html.split(pattern);
    
    for (var part in parts) {
      final trimmed = part.trim();
      if (trimmed.isNotEmpty) {
        blocks.add(trimmed);
      }
    }
    
    return blocks.isNotEmpty ? blocks : [html];
  }

  Widget? _parseBlock(String block, TextStyle defaultStyle) {
    if (block.isEmpty) return null;

    // Check for headings
    if (RegExp(r'<h[1-6]', caseSensitive: false).hasMatch(block)) {
      return _parseHeading(block, defaultStyle);
    }

    // Check for lists
    if (RegExp(r'<ul|<ol', caseSensitive: false).hasMatch(block)) {
      return _parseList(block, defaultStyle);
    }

    // Check for list items
    if (RegExp(r'<li', caseSensitive: false).hasMatch(block)) {
      return _parseListItem(block, defaultStyle);
    }

    // Default paragraph
    return _parseParagraph(block, defaultStyle);
  }

  Widget _parseHeading(String block, TextStyle defaultStyle) {
    final level = _getHeadingLevel(block);
    final text = _stripTags(block);
    
    final fontSize = {
      1: 24.0.sp,
      2: 22.0.sp,
      3: 20.0.sp,
      4: 18.0.sp,
      5: 16.0.sp,
      6: 14.0.sp,
    }[level] ?? 14.0.sp;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Text(
        text,
        style: defaultStyle.copyWith(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  int _getHeadingLevel(String block) {
    final match = RegExp(r'<h([1-6])', caseSensitive: false).firstMatch(block);
    return match != null ? int.parse(match.group(1)!) : 3;
  }

  Widget _parseList(String block, TextStyle defaultStyle) {
    final isOrdered = block.toLowerCase().contains('<ol');
    final items = _extractListItems(block);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(items.length, (index) {
        final bullet = isOrdered ? '${index + 1}.' : '•';
        return Padding(
          padding: EdgeInsets.only(left: 16.w, bottom: 4.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24.w,
                child: Text(bullet, style: defaultStyle),
              ),
              Expanded(
                child: _buildRichText(items[index], defaultStyle),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _parseListItem(String block, TextStyle defaultStyle) {
    final text = _stripTags(block);
    return Padding(
      padding: EdgeInsets.only(left: 16.w, bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24.w,
            child: Text('•', style: defaultStyle),
          ),
          Expanded(
            child: Text(text, style: defaultStyle),
          ),
        ],
      ),
    );
  }

  List<String> _extractListItems(String block) {
    final items = <String>[];
    final pattern = RegExp(r'<li[^>]*>(.*?)</li>', caseSensitive: false, dotAll: true);
    final matches = pattern.allMatches(block);
    
    for (var match in matches) {
      items.add(match.group(1)?.trim() ?? '');
    }
    
    return items;
  }

  Widget _parseParagraph(String block, TextStyle defaultStyle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: _buildRichText(block, defaultStyle),
    );
  }

  Widget _buildRichText(String text, TextStyle defaultStyle) {
    final spans = _parseInlineStyles(text, defaultStyle);
    
    // Use RichText with explicit text direction and overflow handling
    // RichText properly supports TapGestureRecognizer in TextSpans
    return RichText(
      text: TextSpan(
        children: spans,
        style: defaultStyle,
      ),
      // textDirection: TextDirection.ltr,
      overflow: TextOverflow.clip,
    );
  }

  List<TextSpan> _parseInlineStyles(String text, TextStyle defaultStyle) {
    // Remove opening/closing paragraph/div tags
    text = text.replaceAll(RegExp(r'</?(p|div)[^>]*>', caseSensitive: false), '');
    
    // Process text recursively, handling anchor tags first, then inline tags
    return _parseTextWithTags(text, defaultStyle);
  }

  List<TextSpan> _parseTextWithTags(String text, TextStyle defaultStyle) {
    final List<TextSpan> spans = [];
    int lastIndex = 0;
    
    // Pattern to match anchor tags - match href with double quotes or single quotes
    final anchorPatternDouble = RegExp(
      r'<a\s+[^>]*href\s*=\s*"([^"]+)"[^>]*>(.*?)</a>',
      caseSensitive: false,
    );
    final anchorPatternSingle = RegExp(
      r"<a\s+[^>]*href\s*=\s*'([^']+)'[^>]*>(.*?)</a>",
      caseSensitive: false,
    );
    
    // Find all anchor tags
    final List<_TagMatch> tagMatches = [];
    
    for (var match in anchorPatternDouble.allMatches(text)) {
      tagMatches.add(_TagMatch(
        start: match.start,
        end: match.end,
        type: _TagType.anchor,
        href: match.group(1) ?? '',
        content: match.group(2) ?? '',
      ));
    }
    
    for (var match in anchorPatternSingle.allMatches(text)) {
      // Check if this anchor overlaps with any existing anchor (avoid duplicates)
      bool overlaps = false;
      for (var existing in tagMatches) {
        if ((match.start >= existing.start && match.start < existing.end) ||
            (match.end > existing.start && match.end <= existing.end) ||
            (match.start <= existing.start && match.end >= existing.end)) {
          overlaps = true;
          break;
        }
      }
      if (!overlaps) {
        tagMatches.add(_TagMatch(
          start: match.start,
          end: match.end,
          type: _TagType.anchor,
          href: match.group(1) ?? '',
          content: match.group(2) ?? '',
        ));
      }
    }
    
    // Pattern to match inline tags (b, strong, i, em, u, br)
    final inlinePattern = RegExp(
      r'<(b|strong|i|em|u|br)[^>]*>(.*?)</\1>|<br\s*/?>',
      caseSensitive: false,
    );
    
    for (var match in inlinePattern.allMatches(text)) {
      // Check if this match is inside an anchor tag
      bool isInsideAnchor = false;
      for (var anchorMatch in tagMatches) {
        if (match.start >= anchorMatch.start && match.end <= anchorMatch.end) {
          isInsideAnchor = true;
          break;
        }
      }
      
      // Only add if not inside an anchor tag (anchor tags will handle their own content)
      if (!isInsideAnchor) {
        tagMatches.add(_TagMatch(
          start: match.start,
          end: match.end,
          type: _TagType.inline,
          tag: match.group(1)?.toLowerCase() ?? '',
          content: match.group(2) ?? '',
        ));
      }
    }
    
    // Sort matches by start position
    tagMatches.sort((a, b) => a.start.compareTo(b.start));
    
    // Process text segments
    for (var tagMatch in tagMatches) {
      // Add text before the match
      if (tagMatch.start > lastIndex) {
        final beforeText = text.substring(lastIndex, tagMatch.start);
        if (beforeText.isNotEmpty) {
          spans.addAll(_parseSimpleInlineTags(beforeText, defaultStyle));
        }
      }
      
      // Process the match
      if (tagMatch.type == _TagType.anchor) {
        // This is an anchor tag - extract text content and create clickable link
        final url = _resolveUrl(tagMatch.href);
        final linkText = _stripTags(tagMatch.content);
        
        if (linkText.isNotEmpty) {
          // Create TextSpan with TapGestureRecognizer
          final decodedText = _decodeHtml(linkText);
          
          if (kDebugMode) {
            print('Creating link: $url with text: $decodedText');
          }
          
          // Store URL in a local variable for the closure
          final linkUrl = url;
          
          final recognizer = TapGestureRecognizer()
            ..onTap = () {
              if (kDebugMode) {
                print('=== LINK TAPPED ===');
                print('URL: $linkUrl');
                print('Text: $decodedText');
              }
              _handleLinkTap(linkUrl);
            };
          
          spans.add(TextSpan(
            text: decodedText,
            style: defaultStyle.copyWith(
              color: Colors.blue,
              decoration: TextDecoration.underline,
              decorationColor: Colors.blue,
            ),
            recognizer: recognizer,
          ));
        } else {
          if (kDebugMode) {
            print('Link text is empty for URL: $url');
          }
        }
      } else {
        // This is an inline tag (b, strong, i, em, u, br)
        final tag = tagMatch.tag;
        final content = tagMatch.content;
        
        if (tag == 'br' || tag.isEmpty) {
          spans.add(TextSpan(text: '\n'));
        } else if (tag == 'b' || tag == 'strong') {
          final contentSpans = _parseSimpleInlineTags(content, defaultStyle);
          spans.add(TextSpan(
            children: contentSpans.map((span) {
              return TextSpan(
                text: span.text ?? '',
                style: (span.style ?? defaultStyle).copyWith(fontWeight: FontWeight.bold),
                children: span.children,
                recognizer: span.recognizer,
              );
            }).toList(),
          ));
        } else if (tag == 'i' || tag == 'em') {
          final contentSpans = _parseSimpleInlineTags(content, defaultStyle);
          spans.add(TextSpan(
            children: contentSpans.map((span) {
              return TextSpan(
                text: span.text ?? '',
                style: (span.style ?? defaultStyle).copyWith(fontStyle: FontStyle.italic),
                children: span.children,
                recognizer: span.recognizer,
              );
            }).toList(),
          ));
        } else if (tag == 'u') {
          final contentSpans = _parseSimpleInlineTags(content, defaultStyle);
          spans.add(TextSpan(
            children: contentSpans.map((span) {
              return TextSpan(
                text: span.text ?? '',
                style: (span.style ?? defaultStyle).copyWith(decoration: TextDecoration.underline),
                children: span.children,
                recognizer: span.recognizer,
              );
            }).toList(),
          ));
        }
      }
      
      lastIndex = tagMatch.end;
    }
    
    // Add remaining text
    if (lastIndex < text.length) {
      final remainingText = text.substring(lastIndex);
      if (remainingText.isNotEmpty) {
        spans.addAll(_parseSimpleInlineTags(remainingText, defaultStyle));
      }
    }
    
    // If no matches, add the text as is
    if (spans.isEmpty && text.isNotEmpty) {
      spans.add(TextSpan(text: _decodeHtml(_stripTags(text))));
    }
    
    return spans;
  }

  List<TextSpan> _parseSimpleInlineTags(String text, TextStyle defaultStyle) {
    final List<TextSpan> spans = [];
    final pattern = RegExp(
      r'<(b|strong|i|em|u|br)[^>]*>(.*?)</\1>|<br\s*/?>|([^<]+)',
      caseSensitive: false,
      dotAll: true,
    );
    
    final matches = pattern.allMatches(text);
    
    for (var match in matches) {
      final tag = match.group(1)?.toLowerCase();
      final content = match.group(2) ?? match.group(3) ?? '';
      
      if (tag == 'br') {
        spans.add(TextSpan(text: '\n'));
      } else if (tag == 'b' || tag == 'strong') {
        spans.add(TextSpan(
          text: _decodeHtml(_stripTags(content)),
          style: defaultStyle.copyWith(fontWeight: FontWeight.bold),
        ));
      } else if (tag == 'i' || tag == 'em') {
        spans.add(TextSpan(
          text: _decodeHtml(_stripTags(content)),
          style: defaultStyle.copyWith(fontStyle: FontStyle.italic),
        ));
      } else if (tag == 'u') {
        spans.add(TextSpan(
          text: _decodeHtml(_stripTags(content)),
          style: defaultStyle.copyWith(decoration: TextDecoration.underline),
        ));
      } else if (content.isNotEmpty) {
        spans.add(TextSpan(text: _decodeHtml(_stripTags(content))));
      }
    }
    
    if (spans.isEmpty && text.isNotEmpty) {
      spans.add(TextSpan(text: _decodeHtml(_stripTags(text))));
    }
    
    return spans;
  }

  String _resolveUrl(String href) {
    if (href.isEmpty) return '';
    
    // If it's already an absolute URL, return as is
    if (href.startsWith('http://') || href.startsWith('https://')) {
      if (kDebugMode) {
        print('URL is already absolute: $href');
      }
      return href;
    }
    
    // Handle relative URLs
    // Remove all leading ../ or ./ patterns
    String cleanPath = href;
    while (cleanPath.startsWith('../') || cleanPath.startsWith('./')) {
      if (cleanPath.startsWith('../')) {
        cleanPath = cleanPath.substring(3);
      } else if (cleanPath.startsWith('./')) {
        cleanPath = cleanPath.substring(2);
      }
    }
    
    // If it starts with /, it's an absolute path on the server
    if (cleanPath.startsWith('/')) {
      final resolvedUrl = '$baseUrl$cleanPath';
      if (kDebugMode) {
        print('Resolved URL (absolute path): $resolvedUrl');
      }
      return resolvedUrl;
    }
    
    // Otherwise, it's a relative path
    final resolvedUrl = '$baseUrl/$cleanPath';
    if (kDebugMode) {
      print('Resolved URL (relative path): $resolvedUrl (from: $href)');
    }
    return resolvedUrl;
  }

  Future<void> _handleLinkTap(String url) async {
    if (url.isEmpty) return;
    
    try {
      // Check if it's a PDF file
      if (url.toLowerCase().endsWith('.pdf')) {
        // Navigate to PDF viewer
        if (kDebugMode) {
          print("Opening PDF: $url");
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Pdfviewer(url),
          ),
        );
      } else {
        // Use url_launcher for other URLs
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          if (kDebugMode) {
            print('Could not launch $url');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error handling link tap: $e');
      }
    }
  }

  String _stripTags(String html) {
    if (html.isEmpty) return '';
    try {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    } catch (e) {
      if (kDebugMode) {
        print('Error stripping tags: $e');
      }
      return html;
    }
  }

  String _decodeHtml(String text) {
    if (text.isEmpty) return '';
    try {
    return text
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('&apos;', "'")
        .trim();
    } catch (e) {
      if (kDebugMode) {
        print('Error decoding HTML: $e');
      }
      return text;
    }
  }
}

/// Embedded PDF viewer widget that loads PDF with authentication
class _EmbeddedPdfViewer extends StatefulWidget {
  final String pdfUrl;

  const _EmbeddedPdfViewer({required this.pdfUrl});

  @override
  State<_EmbeddedPdfViewer> createState() => _EmbeddedPdfViewerState();
}

class _EmbeddedPdfViewerState extends State<_EmbeddedPdfViewer> {
  bool _isLoading = true;
  String? _errorMessage;
  Uint8List? _pdfBytes;
  bool _isDisposed = false;
  bool _shouldLoad = false;

  @override
  void initState() {
    super.initState();
    // Don't load PDF immediately - wait for widget to be visible
    // This prevents memory issues on older devices
    // Load after a delay to ensure the widget tree is stable
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted && !_isDisposed) {
        setState(() {
          _shouldLoad = true;
        });
        _loadPdf();
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> _loadPdf() async {
    if (_isDisposed || !mounted) return;
    
    try {
      if (!mounted) return;
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // Get authentication token
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      final String? token = preferences.getString('token');

      if (_isDisposed || !mounted) return;

      // Validate URL before making request
      if (widget.pdfUrl.isEmpty) {
        if (mounted && !_isDisposed) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Invalid PDF URL';
          });
        }
        return;
      }

      // Download PDF with authentication headers
      final response = await http.get(
        Uri.parse(widget.pdfUrl),
        headers: {
          if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
          'Content-Type': 'application/pdf',
          'Accept': 'application/pdf',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('PDF download timeout');
        },
      );

      if (_isDisposed || !mounted) return;

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        
        // Validate PDF bytes (PDF files start with %PDF)
        if (bytes.isEmpty || 
            (bytes.length >= 4 && 
             String.fromCharCodes(bytes.take(4)) != '%PDF')) {
          if (mounted && !_isDisposed) {
            setState(() {
              _isLoading = false;
              _errorMessage = 'Invalid PDF file';
            });
          }
          return;
        }

        _pdfBytes = bytes;
        if (mounted && !_isDisposed) {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        if (mounted && !_isDisposed) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Failed to load PDF. Status code: ${response.statusCode}';
          });
        }
      }
    } catch (e) {
      if (_isDisposed || !mounted) return;
      
      if (mounted && !_isDisposed) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error loading PDF: ${e.toString()}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Don't start loading until widget is ready
    if (!_shouldLoad) {
      return SizedBox(
        height: 500.h,
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (_isLoading) {
      return SizedBox(
        height: 500.h,
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return SizedBox(
        height: 500.h,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 40.sp),
                SizedBox(height: 8.h),
                Flexible(
                  child: Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 12.sp),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_pdfBytes != null) {
      try {
        // Parent container already has height constraint, so use Expanded or fill available space
        // Don't add another SizedBox with height here
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: SfPdfViewer.memory(_pdfBytes!),
        );
      } catch (e, stackTrace) {
        if (kDebugMode) {
          print('Error displaying PDF: $e');
          print('Stack trace: $stackTrace');
        }
        return SizedBox(
          height: 500.h,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 40.sp),
                  SizedBox(height: 8.h),
                  Flexible(
                    child: Text(
                      'Error displaying PDF. Please try again.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return SizedBox(
      height: 500.h,
      child: const Center(
        child: Text('No PDF data available'),
      ),
    );
  }
}