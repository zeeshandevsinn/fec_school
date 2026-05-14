// ignore_for_file: unused_element
import 'package:fec_app2/providers/events_provider.dart';
import 'package:fec_app2/screen_pages/dashboard.dart';
import 'package:fec_app2/screen_pages/event_title.dart';
import 'package:fec_app2/services.dart/push_notifications/notification_service.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class EventScreen extends StatefulWidget {
  static const String routeName = '/events';

  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final EventsProvider _eventsProvider = EventsProvider();
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
        body: SingleChildScrollView(
          physics: const PageScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
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
                                'Events',
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
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 15.h),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.73,
                      decoration: const BoxDecoration(),
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                          future: _eventsProvider.getsUsers(),
                          builder: (context,
                              AsyncSnapshot<List<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              List<Map<String, dynamic>>? eventData =
                                  snapshot.data!;

                              return eventData.isEmpty
                                  ? const Center(
                                      child: Text(""),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: eventData.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EventTitle(
                                                                  id: eventData[
                                                                          index]
                                                                      ["id"],
                                                                  eventsValue:
                                                                      eventData[
                                                                          index])));
                                                },
                                                child: Container(
                                                  width: double.infinity.w,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: ListTile(
                                                      title: Text(
                                                        (eventData[index][
                                                                        "title"] ==
                                                                    null ||
                                                                eventData[index]
                                                                        [
                                                                        "title"] ==
                                                                    "")
                                                            ? "No title for this Event"
                                                            : eventData[index]
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
                                                              (eventData[index][
                                                                              "summary"] ==
                                                                          null ||
                                                                      eventData[index]
                                                                              [
                                                                              "summary"] ==
                                                                          "")
                                                                  ? "No summary for this Event"
                                                                  : eventData[index]
                                                                          [
                                                                          "summary"]
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12.sp)),
                                                          SizedBox(height: 5.h),
                                                          Text(
                                                            (eventData[index][
                                                                            "created_at"] ==
                                                                        null ||
                                                                    eventData[index]
                                                                            [
                                                                            "created_at"] ==
                                                                        "")
                                                                ? "No DateTime for this Event"
                                                                : DateFormat(
                                                                        'dd-MM-yyyy - HH:mm')
                                                                    .format(DateTime.tryParse(eventData[index]
                                                                            [
                                                                            "created_at"]!
                                                                        .toString())!),
                                                            style: TextStyle(
                                                                fontSize:
                                                                    10.sp),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5.h),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w),
                                                  child: const Divider(
                                                      color: Colors.black26)),
                                              SizedBox(height: 5.h),
                                            ],
                                          );
                                        },
                                      ),
                                    );
                            }
                            return const Center(
                                child: Text('Something went wrong'));
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
