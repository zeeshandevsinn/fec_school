import 'package:fec_app2/screen_pages/child_info.dart';
import 'package:fec_app2/screen_pages/events.dart';
import 'package:fec_app2/screen_pages/folders_all.dart';
import 'package:fec_app2/screen_pages/forms.dart';
import 'package:fec_app2/screen_pages/notices.dart';
import 'package:fec_app2/screen_pages/email_contacts_page.dart';
import 'package:fec_app2/screen_pages/call_contacts_page.dart';
import 'package:fec_app2/screen_pages/profile.dart';
import 'package:fec_app2/services.dart/push_notifications/notification_service.dart';
import 'package:fec_app2/utils/map_location_services.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  static const String routeName = '/dashboard';
  // ignore: prefer_typing_uninitialized_variables

  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String? userName = '';
  bool isFinished = false;

  void nameAccessing() async {
    final preferences = await SharedPreferences.getInstance();
    String? name = preferences.getString('name');
    setState(() {
      userName = name ?? '';
    });
  }

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
    nameAccessing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: const BoxDecoration(),
              child: Stack(
                children: [
                  ClipPath(
                    clipper: CurvedBottomClipper2(),
                    child: Container(
                      color: Colors.amber,
                      height: 212.h,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: -20,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 80.w),
                          child: ClipPath(
                            clipper: CurvedBottomClipper(),
                            child: Stack(
                              children: [
                                Container(
                                  color: Colors.amber,
                                  height: 211.h,
                                  width: 400.w,
                                  child: Image.asset(
                                      'assets/images/dashboard.png',
                                      fit: BoxFit.cover,
                                      alignment:
                                          const FractionalOffset(0, -0.5)),
                                ),
                                Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      color:
                                          const Color.fromARGB(255, 25, 74, 159)
                                              .withValues(alpha: 0.6),
                                      height: 211.h,
                                      width: 400.w,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            top: 85.h,
                            left: 20.w,
                            child: Container(
                              width: 300.w,
                              transformAlignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent),
                              child: Center(
                                child: Text(
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  userName!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.sp),
                                ),
                              ),
                            )),
                        Positioned(
                            top: 95.h,
                            left: 70.w,
                            child: Container(
                              width: 200.w,
                              decoration: const BoxDecoration(
                                  color: Colors.transparent),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Welcome to FEC',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )),
                        Positioned(
                          left: 20.w,
                          top: 175.h,
                          child: Container(
                            height: 40.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              border:
                                  Border.all(width: 05, color: Colors.amber),
                              color: const Color.fromARGB(255, 25, 74, 159),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, CallContactsPage.routeName);
                                },
                                icon: Image.asset('assets/images/phone.png',
                                    color: Colors.white)),
                          ),
                        ),
                        Positioned(
                          left: 95.w,
                          top: 190.h,
                          child: Container(
                            height: 40.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              border:
                                  Border.all(width: 05, color: Colors.amber),
                              color: const Color.fromARGB(255, 25, 74, 159),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, EmailContactsPage.routeName);
                                },
                                icon: Image.asset(
                                  'assets/images/mail.png',
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        Positioned(
                            left: 175.w,
                            top: 188.h,
                            child: Container(
                                height: 40.h,
                                width: 45.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  border: Border.all(
                                      width: 05, color: Colors.amber),
                                  color: const Color.fromARGB(255, 25, 74, 159),
                                ),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MapLocationServices()));
                                    },
                                    icon: Image.asset(
                                        'assets/images/location.png',
                                        color: Colors.white)))),
                        Positioned(
                          left: 250.w,
                          top: 165.h,
                          child: Container(
                            height: 40.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              border:
                                  Border.all(width: 05, color: Colors.amber),
                              color: const Color.fromARGB(255, 25, 74, 159),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, ChildInformation.routeName);
                                },
                                icon: Image.asset(
                                  'assets/images/childreninfo.png',
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        Positioned(
                          left: 310.w,
                          top: 125.h,
                          child: Container(
                            height: 40.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              border:
                                  Border.all(width: 05, color: Colors.amber),
                              color: const Color.fromARGB(255, 25, 74, 159),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, ProfileInfo.routeName);
                                },
                                icon: Image.asset(
                                  'assets/images/profile.png',
                                  color: Colors.white,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
                child: Text(
              'Dashboard',
              style: TextStyle(
                  fontSize: 30.sp,
                  color: const Color.fromARGB(255, 25, 74, 159),
                  fontWeight: FontWeight.w700),
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: const Divider(color: Colors.black),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, NoticesScreen.routeName);
                },
                child: Container(
                  height: 55.h,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(05.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 55.h,
                        width: 55.w,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 25, 74, 159),
                            borderRadius: BorderRadius.circular(07.r)),
                        child: Image.asset('assets/images/notices.png'),
                      ),
                      SizedBox(width: 15.w),
                      const Text('Notices'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, EventScreen.routeName);
                },
                child: Container(
                  height: 55.h,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(05.r)),
                  child: Row(
                    children: [
                      Container(
                        height: 55.h,
                        width: 55.w,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 25, 74, 159),
                            borderRadius: BorderRadius.circular(07.r)),
                        child: Image.asset('assets/images/events.png'),
                      ),
                      SizedBox(width: 15.w),
                      const Text('Events')
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, FormScreen.routeName);
                },
                child: Container(
                  height: 55.h,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(05.r)),
                  child: Row(
                    children: [
                      Container(
                        height: 55.h,
                        width: 55.w,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 25, 74, 159),
                            borderRadius: BorderRadius.circular(07.r)),
                        child: Image.asset('assets/images/forms.png'),
                      ),
                      SizedBox(width: 15.w),
                      const Text('Forms'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, FoldersAll.routeName);
        },
        hoverElevation: 0,
        focusElevation: 0,
        backgroundColor: Colors.grey.shade200,
        elevation: 0.5,
        child: SvgPicture.asset("assets/svg/listsolid.svg",
            width: 25.0, height: 25.0),
      ),
    ));
  }
}
