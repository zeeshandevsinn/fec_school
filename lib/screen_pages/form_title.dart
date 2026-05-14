import 'package:fec_app2/providers/dash_form_provider.dart';
import 'package:fec_app2/providers/date_time_provider.dart';
import 'package:fec_app2/providers/events_provider.dart';
import 'package:fec_app2/providers/file_picker_provider.dart';
import 'package:fec_app2/screen_pages/forms.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FormTitle extends StatefulWidget {
  final int? id;
  final Map<String, dynamic> formDataData;
  const FormTitle({super.key, required this.id, required this.formDataData});

  @override
  State<FormTitle> createState() => _FormTitleState();
}

class _FormTitleState extends State<FormTitle> {
  final FormsSingleProvider _formsSingleProvider = FormsSingleProvider();
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> singleFormData = [];
  @override
  void initState() {
    getSingleFormData();
    super.initState();
  }

  getSingleFormData() async {
    singleFormData = await _formsSingleProvider.getsSingleForms(widget.id);
    for (var element in singleFormData) {
      String type = element['type'];
      String uniqueName = element['name'];
      // ignore: use_build_context_synchronously
      Provider.of<IntializeFormFieldsProvider>(context, listen: false)
          .initializationOfControllers(uniqueName, type);
    }
    setState(() {});
  }

  void _submitFormData(BuildContext context) async {
    bool isvalid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isvalid) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<SubmissionProcessForFormProvider>(context, listen: false)
        .submissionProcessFormData(
            context,
            widget.id,
            Provider.of<IntializeFormFieldsProvider>(context, listen: false)
                .textNumberFileDateControllers,
            Provider.of<IntializeFormFieldsProvider>(context, listen: false)
                .filesControllers,
            Provider.of<IntializeFormFieldsProvider>(context, listen: false)
                .checkBoxesValues,
            Provider.of<IntializeFormFieldsProvider>(context, listen: false)
                .radioButtonsValues,
            Provider.of<IntializeFormFieldsProvider>(context, listen: false)
                .dropdownsValue);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<IntializeFormFieldsProvider>(context);
    Provider.of<FilePickerProvider>(context);
    Provider.of<DateTimeProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 25, 74, 159),
          flexibleSpace: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: IconButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, FormScreen.routeName);
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
            title: Text(
              (widget.formDataData["name"] == null ||
                      widget.formDataData["name"] == "")
                  ? "No Form Name"
                  : widget.formDataData["name"].toString(),
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
            subtitle: Text(
              (widget.formDataData["created_at"] == null ||
                      widget.formDataData["created_at"] == "")
                  ? "No DateTime"
                  : DateFormat('dd-MM-yyyy - HH:mm').format(
                      DateTime.parse(widget.formDataData["created_at"])),
              style: TextStyle(color: Colors.white, fontSize: 10.sp),
            ),
          ),
          actions: [
            Container(
                height: 50.h,
                width: 80.w,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Image.asset('assets/images/feclogos.png'))
          ],
        ),
        body: SingleChildScrollView(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              ClipPath(
                clipper: StraightBorderClipper(
                    borderWidth: 0), // Adjust the border width as needed
                child: Container(
                  height: 10.h,
                  width: double.infinity.w,
                  color: Colors.amber,
                ),
              ),
              Form(
                key: _formKey,
                child: Consumer<IntializeFormFieldsProvider>(
                  builder: (context, formProvider, child) {
                    return ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: singleFormData.length,
                      itemBuilder: (context, index) {
                        var fields = singleFormData[index];
                        String type = fields['type'];
                        String fieldsName = fields['name'];

                        if (type == 'text' ||
                            type == 'number' ||
                            type == 'textarea') {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: TextFormField(
                              controller: formProvider
                                  .textNumberFileDateControllers[fieldsName],
                              decoration: InputDecoration(
                                  enabled: true,
                                  border: const UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  labelText: fields['label']),
                            ),
                          );
                        } else if (type == 'select') {
                          return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 4.h),
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.r)),
                                      border: Border.all()),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 2.h),
                                    child: DropdownButtonFormField<String>(
                                      value: formProvider
                                          .dropdownsValue[fieldsName],
                                      items: (fields['values'] as List<dynamic>)
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item['value'],
                                                child: Text(item['label']),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        formProvider.setDropdownsValues(
                                            fieldsName, value!);
                                      },
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                      ),
                                      hint: Text(fields['label']),
                                    ),
                                  )));
                        } else if (type == 'radio-group') {
                          return Column(
                            children: (fields['values'] as List<dynamic>)
                                .map((item) => Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 4.h),
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.r)),
                                          border: Border.all()),
                                      child: RadioListTile<String>(
                                        activeColor: const Color.fromARGB(
                                            255, 25, 74, 159),
                                        value: item['value'],
                                        groupValue: formProvider
                                            .radioButtonsValues[fieldsName],
                                        onChanged: (value) {
                                          formProvider.setRadioButtonsValues(
                                              fieldsName, value!);
                                        },
                                        title: Text(item['label']),
                                      ),
                                    )))
                                .toList(),
                          );
                        } else if (type == 'checkbox-group') {
                          return Column(
                            children: (fields['values'] as List<dynamic>)
                                .map((item) => Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.r)),
                                          border: Border.all()),
                                      child: CheckboxListTile(
                                        activeColor: const Color.fromARGB(
                                            255, 25, 74, 159),
                                        value: formProvider
                                                .checkBoxesValues[fieldsName]
                                                ?.contains(item['value']) ??
                                            false,
                                        onChanged: (bool? checked) {
                                          formProvider.togglesCheckboxesValues(
                                              fieldsName, item['value']);
                                        },
                                        title: Text(item['label']),
                                      ),
                                    )))
                                .toList(),
                          );
                        } else if (type == 'file') {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Consumer<FilePickerProvider>(
                              builder: (context, fpp, child) => TextFormField(
                                focusNode: FocusNode(),
                                controller:
                                    formProvider.filesControllers[fieldsName],
                                readOnly: true,
                                decoration: InputDecoration(
                                    enabled: true,
                                    border: const UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    labelText: fields['label'],
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(8)),
                                onTap: () async {
                                  formProvider
                                          .filesControllers[fieldsName]!.text =
                                      await fpp.filePickerFromGallery(context);
                                },
                              ),
                            ),
                          );
                        } else if (type == 'date') {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Consumer<DateTimeProvider>(
                              builder: (context, dp, child) => TextFormField(
                                controller: formProvider
                                    .textNumberFileDateControllers[fieldsName],
                                keyboardType: TextInputType.datetime,
                                readOnly: true,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    enabled: true,
                                    border: const UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    labelText: fields['label'],
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(8)),
                                onTap: () async {
                                  formProvider
                                      .textNumberFileDateControllers[
                                          fieldsName]!
                                      .text = await dp.dateTimePicker(context);
                                },
                              ),
                            ),
                          );
                        } else if (type.toString().toLowerCase() == 'button' &&
                            fields["subtype"].toString().toLowerCase() ==
                                "submit") {
                          return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SizedBox(
                                height: 45.h,
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: const ButtonStyle(
                                        shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                                side: BorderSide.none)),
                                        backgroundColor: WidgetStatePropertyAll(
                                            Color.fromARGB(255, 25, 74, 159))),
                                    onPressed: () {
                                      _submitFormData(context);
                                    },
                                    child: Text(fields['label'],
                                        style: const TextStyle(
                                            color: Colors.white))),
                              ));
                        }
                        return SizedBox.shrink();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
