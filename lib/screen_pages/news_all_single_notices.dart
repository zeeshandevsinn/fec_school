import 'package:fec_app2/providers/checkbox_provider.dart';
import 'package:fec_app2/providers/date_time_provider.dart';
import 'package:fec_app2/providers/dropdown_provider.dart';
import 'package:fec_app2/providers/file_picker_provider.dart';
import 'package:fec_app2/providers/formdata_submission.dart';
import 'package:fec_app2/providers/initial_textformfield_provider.dart';
import 'package:fec_app2/providers/profile_provider.dart';
import 'package:fec_app2/providers/radiogroup_provider.dart';
// Removed pdfviewer import as it's no longer used after removing HtmlWidget
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Removed flutter_widget_from_html import due to App Store compliance
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewsAllSingleNotices extends StatefulWidget {
  final int? id;
  final Map<String, dynamic> newNotice;

  const NewsAllSingleNotices({super.key, this.id, required this.newNotice});

  @override
  State<NewsAllSingleNotices> createState() => _NewsAllSingleNoticesState();
}

class _NewsAllSingleNoticesState extends State<NewsAllSingleNotices> {
  final _formKey = GlobalKey<FormState>();
  DateFormat dateFormat = DateFormat("dd-mm-yyyy");
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

  ProfileProvider profileProvider = ProfileProvider();

  @override
  void initState() {
    getInitailizeProvider();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
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
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
          title: Text(
            (widget.newNotice["title"] == null ||
                    widget.newNotice["title"] == "")
                ? "No Notice's Title"
                : widget.newNotice["title"].toString(),
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
          subtitle: Text(
            (widget.newNotice["created_at"] == null ||
                    widget.newNotice["created_at"] == "")
                ? "No DateTime"
                : DateFormat('dd-MM-yyyy - HH:mm').format(DateTime.tryParse(
                    widget.newNotice["created_at"]!.toString())!),
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
              Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          '''${(widget.newNotice["description"] == null || widget.newNotice["description"] == "") ? "No Description for such Notice" : widget.newNotice["description"]}''',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      )),
                ],
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  child: Consumer<InitialTextformfieldProvider>(
                    builder: (context, initProvider, child) =>
                        Column(children: [
                      initProvider.isloading == false
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : initProvider.particularForm!.isEmpty
                              ? const Center(
                                  child: Text("Something went wrong"))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      initProvider.particularForm!.length,
                                  itemBuilder: (context, index) {
                                    List<dynamic>? singleInitForm =
                                        initProvider.particularForm![index]
                                                ["form_data"] ??
                                            [];

                                    return Column(
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
                                          if (singleInitForm[l]["type"]
                                                      .toString()
                                                      .toLowerCase() ==
                                                  "button" &&
                                              singleInitForm[l]["subtype"]
                                                      .toString()
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
                                                        _submitFormData(
                                                            context,
                                                            initProvider
                                                                    .particularForm![
                                                                index]["form_id"]);
                                                      },
                                                      child: Text(
                                                        singleInitForm[l]
                                                                ["type"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                ))
                                      ],
                                    );
                                  }),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
