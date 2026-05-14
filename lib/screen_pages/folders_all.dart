import 'package:fec_app2/providers/folder_provider.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/screen_pages/single_folder.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FoldersAll extends StatefulWidget {
  static const String routeName = '/folder-all';
  const FoldersAll({super.key});

  @override
  State<FoldersAll> createState() => _FoldersAllState();
}

class _FoldersAllState extends State<FoldersAll> {
  final FoldersProvider _foldersProvider = FoldersProvider();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              decoration: const BoxDecoration(),
              child: Stack(
                children: [
                  ClipPath(
                    clipper: CurvedBottomClipper4(),
                    child: Container(
                      color: Colors.amber,
                      height: 140.h,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: CurvedBottomClipper3(),
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.amber,
                                height: 133.h,
                                width: 400.w,
                                child: Image.asset(
                                  'assets/images/dashboard.png',
                                  fit: BoxFit.cover,
                                  alignment: const FractionalOffset(1, 1),
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    color:
                                        const Color.fromARGB(255, 25, 74, 159)
                                            .withValues(alpha: 0.6),
                                    height: 133.h,
                                    width: 400.w,
                                  )),
                            ],
                          ),
                        ),
                        Positioned(
                            top: 40.h,
                            left: 100.w,
                            right: 150.w,
                            child: Text(
                              'All Folders',
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
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
           Expanded(child: 
           FutureBuilder<List<Map<String, dynamic>>>(
  future: _foldersProvider.getFolders(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError || snapshot.data == null) {
      return const Center(child: Text('Something went wrong'));
    }

    final List<Map<String, dynamic>> foldersData = snapshot.data!;

    if (foldersData.isEmpty) {
      return const Center(child: Text("No folder yet"));
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      itemCount: foldersData.length,
      itemBuilder: (context, index) {
        final folder = foldersData[index];
        final folderName = folder["folder"]?["name"] ?? "";
        final folderId = folder["folder"]?["id"];

        return Column(
          children: [
            GestureDetector(
              onTap: () {
                if (folderId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SingleFolder(
                        id: folderId,
                        folderData: folder,
                      ),
                    ),
                  );
                } else {
                  Fluttertoast.showToast(msg: "Folder ID not found");
                }
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListTile(
                    title: Text(
                      folderName.isEmpty
                          ? "No folder name has been defined"
                          : folderName,
                      style: TextStyle(fontSize: 15.sp),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: const Divider(color: Colors.black26),
            ),
            SizedBox(height: 5.h),
          ],
        );
      },
    );
  },
)

           )
          ],
        ),
      ),
    );
  }
}
