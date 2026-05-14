import 'package:fec_app2/providers/notices_provider.dart';
import 'package:fec_app2/screen_pages/news_all_single_notices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SingleSubOfSubFolder extends StatefulWidget {
  static const String routeName = '/single-subOfSubforlder';
  final int subOfSubFoldId;
  final Map<String, dynamic> subOfSubFoldersFolders;
  const SingleSubOfSubFolder(
      {super.key,
      required this.subOfSubFoldId,
      required this.subOfSubFoldersFolders});

  @override
  State<SingleSubOfSubFolder> createState() => _SingleSubOfSubFolderState();
}

class _SingleSubOfSubFolderState extends State<SingleSubOfSubFolder> {
  final NoticesIdsProvider _noticesIdsProvider = NoticesIdsProvider();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 25, 74, 159),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
          title: ListTile(
            title: Text(
              (widget.subOfSubFoldersFolders["folder"]["name"] == null ||
                      widget.subOfSubFoldersFolders["folder"]["name"] == "")
                  ? "No Folder Name"
                  : widget.subOfSubFoldersFolders["folder"]["name"].toString(),
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
          actions: [
            Container(
                width: 70.w,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Image.asset('assets/images/feclogos.png'))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(),
                child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _noticesIdsProvider.getIdsData(),
                    builder: (context,
                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      List<Map<String, dynamic>> noticeData =
                          snapshot.data!.where((notice) {
                        if (notice["folder_id"] != null &&
                            notice["folder_id"].toString().isNotEmpty) {
                          return notice["folder_id"]
                              .toString()
                              .split(',')
                              .map((id) {
                                id = id.trim();
                                try {
                                  return int.parse(id);
                                } catch (e) {
                                  return null;
                                }
                              })
                              .where((id) => id != null)
                              .toList()
                              .contains(widget.subOfSubFoldersFolders["folder"]
                                  ["id"]);
                        } else {
                          return notice["folder_id"]
                              .toString()
                              .split(',')
                              .map((id) {
                                id = id.trim();
                                try {
                                  return int.parse(id);
                                } catch (e) {
                                  return null;
                                }
                              })
                              .where((id) => id != null)
                              .toList()
                              .contains(widget.subOfSubFoldersFolders["folder"]
                                  ["id"]);
                        }
                      }).toList();
                      // noticeData.forEach((notice) {
                      //   print(
                      //       "${notice["folder_id"]} == ${widget.subOfSubFoldersFolders["folder"]["id"]}");
                      // });

                      return noticeData.isEmpty
                          ? const Center(
                              child: Text(""),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: noticeData.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NewsAllSingleNotices(
                                                            id: noticeData[
                                                                index]["id"],
                                                            newNotice:
                                                                noticeData[
                                                                    index])));
                                          },
                                          child: Container(
                                            width: double.infinity.w,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: ListTile(
                                                  title: Text(
                                                    (noticeData[index]
                                                                    ["title"] ==
                                                                null ||
                                                            noticeData[index]
                                                                    ["title"] ==
                                                                "")
                                                        ? "No title for this notice"
                                                        : noticeData[index]
                                                                ["title"]
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 15.sp),
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          (noticeData[index][
                                                                          "summary"] ==
                                                                      null ||
                                                                  noticeData[index]
                                                                          [
                                                                          "summary"] ==
                                                                      "")
                                                              ? "No summary for this notice"
                                                              : noticeData[
                                                                          index]
                                                                      [
                                                                      "summary"]
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12.sp)),
                                                      SizedBox(height: 05.h),
                                                      Text(
                                                        (noticeData[index][
                                                                        "created_at"] ==
                                                                    null ||
                                                                noticeData[index]
                                                                        [
                                                                        "created_at"] ==
                                                                    "")
                                                            ? "No DateTime for this notice"
                                                            : DateFormat(
                                                                    'dd-MM-yyyy - HH:mm')
                                                                .format(DateTime.tryParse(noticeData[
                                                                            index]
                                                                        [
                                                                        "created_at"]!
                                                                    .toString())!),
                                                        style: TextStyle(
                                                            fontSize: 10.sp),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                      ],
                                    );
                                  }),
                            );
                    }),
              ),
              SizedBox(height: 5.h),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: const Divider(color: Colors.black26)),
              SizedBox(height: 5.h),
              if ((widget.subOfSubFoldersFolders["subFolders"] as List).isEmpty)
                Center(
                  child: Text(""),
                ),
              if ((widget.subOfSubFoldersFolders["subFolders"] as List)
                  .isNotEmpty)
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: const BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: (widget.subOfSubFoldersFolders["subFolders"]
                                as List)
                            .length,
                        itemBuilder: (context, index) {
                          final foldOrSubOfSubFold =
                              (widget.subOfSubFoldersFolders["subFolders"]
                                  as List)[index];
                          return Column(children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: double.infinity.w,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: ListTile(
                                      title: Text(
                                        (foldOrSubOfSubFold["folder"]["name"] ==
                                                    null ||
                                                foldOrSubOfSubFold["folder"]
                                                        ["name"] ==
                                                    "")
                                            ? "No folder name has been defined"
                                            : foldOrSubOfSubFold["folder"]
                                                    ["name"]
                                                .toString(),
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: const Divider(color: Colors.black26)),
                            SizedBox(height: 2.h),
                          ]);
                        }),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
