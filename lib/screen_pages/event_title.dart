import 'package:fec_app2/screen_pages/events.dart';
import 'package:fec_app2/services.dart/push_notifications/notification_service.dart';
import 'package:fec_app2/widgets/curved_botton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Removed flutter_widget_from_html import due to App Store compliance
import 'package:intl/intl.dart';
// Removed url_launcher import as it's no longer used after removing HtmlWidget

class EventTitle extends StatefulWidget {
  final Map<String, dynamic>? eventsValue;
  final int? id;
  final String? eid;
  final String? etype;
  const EventTitle(
      {super.key, this.eventsValue, this.id, this.eid, this.etype});

  @override
  State<EventTitle> createState() => _EventTitleState();
}

class _EventTitleState extends State<EventTitle> {
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 25, 74, 159),
          flexibleSpace: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: IconButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, EventScreen.routeName);
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
            title: Text(
              (widget.eventsValue!["title"] == null ||
                      widget.eventsValue!["title"] == "")
                  ? "No Event's Title"
                  : widget.eventsValue!["title"].toString(),
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
            subtitle: Text(
              (widget.eventsValue!["created_at"] == null ||
                      widget.eventsValue!["created_at"]! == "")
                  ? "No DateTime"
                  : DateFormat('dd-MM-yyyy - HH:mm').format(
                      DateTime.parse(widget.eventsValue!["created_at"])),
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
        body: SingleChildScrollView(
            physics: const PageScrollPhysics(),
            scrollDirection: Axis.vertical,
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
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        (widget.eventsValue!["description"] == null ||
                                widget.eventsValue!["description"] == "")
                            ? "No Description for such Event"
                            : widget.eventsValue!["description"],
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    )),
              ],
            )),
      ),
    );
  }
}
