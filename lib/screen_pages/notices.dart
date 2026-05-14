import 'dart:developer';

import 'package:fec_app2/providers/notices_provider.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/screen_pages/notice_title.dart';
import 'package:fec_app2/services.dart/push_notifications/notification_service.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NoticesScreen extends StatefulWidget {
  static const String routeName = '/notices';
  const NoticesScreen({super.key});

  @override
  State<NoticesScreen> createState() => _NoticesScreenState();
}

class _NoticesScreenState extends State<NoticesScreen> {
  final ApiService _apiService = ApiService();
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
                            left: 130.w,
                            right: 130.w,
                            child: Text(
                              'Notices',
                              style: TextStyle(
                                  fontSize: 25.sp,
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
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _apiService.getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    List<Map<String, dynamic>> noticeData = snapshot.data!;
                    if (noticeData.isEmpty) {
                      return const Center(child: Text("No notices available"));
                    }
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                      itemCount: noticeData.length,
                      itemBuilder: (context, index) {
                        final notice = noticeData[index];
                        return GestureDetector(
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoticeTitle(
                      id: notice["id"],
                      newNotice: notice,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListTile(
                        title: Text(
                          (notice["title"] ?? "").isEmpty
                              ? "No title for this notice"
                              : notice["title"],
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (notice["summary"] ?? "").isEmpty
                                  ? "No summary for this notice"
                                  : notice["summary"],
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              (notice["created_at"] ?? "").isEmpty
                                  ? "No DateTime for this notice"
                                  : DateFormat('dd-MM-yyyy - HH:mm').format(
                                      DateTime.tryParse(notice["created_at"])!),
                              style: TextStyle(fontSize: 10.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  const Divider(color: Colors.black26),
                  SizedBox(height: 5.h),
                ],
              ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('Something went wrong'));
                  }
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
