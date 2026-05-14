// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:fec_app2/providers/events_provider.dart';
import 'package:fec_app2/providers/notices_provider.dart';
import 'package:fec_app2/screen_pages/event_title.dart';
import 'package:fec_app2/screen_pages/notice_title.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

class PushNotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();
  Timer? _debouncing;

  void requestForNotificationPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('authorized permission granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('provisional permission also granted');
    } else {
      debugPrint('permission not granted');
    }
  }

  Future<void> initializationNotifications(
      BuildContext context, RemoteMessage notificationMessage) async {
    tz.initializeTimeZones();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    DarwinInitializationSettings darwinInitializationSettings =
        const DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payLoad) async {
      await messagesHandling(context, notificationMessage);
      behaviorSubject.add(payLoad.payload!);
    });
  }

  void notificationInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((notificationMessage) async {
      String? titleValue = notificationMessage.notification!.title.toString();
      String? bodyValue = notificationMessage.notification!.body.toString();
      debugPrint(titleValue);
      debugPrint(bodyValue);
      debugPrint(notificationMessage.data['mtype'].toString());
      debugPrint(notificationMessage.data['mid'].toString());
      if (Platform.isAndroid) {
        await initializationNotifications(context, notificationMessage);
      }
      await showNotification(title: titleValue, body: bodyValue);
      behaviorSubject
          .listen((value) => messagesHandling(context, notificationMessage));
    });
  }

  Future<String?> getDeviceToken() async {
    try {
      // On iOS, ensure APNS token is available first
      if (Platform.isIOS) {
        try {
          await messaging.getAPNSToken();
        } catch (e) {
          // APNS token might not be available yet, that's okay
          debugPrint('APNS token not available yet: $e');
        }
      }
      String? tokenValue = await messaging.getToken();
      return tokenValue;
    } catch (e) {
      debugPrint('Error getting device token: $e');
      return null;
    }
  }

  void getDeviceTokenRefreshing(BuildContext context) {
    messaging.onTokenRefresh.listen((event) {
      log("Token Refreshed $event");
    });
  }

  Future<void> setUpMessageInteraction(BuildContext context) async {
    _debouncing?.cancel();

    /// When App is in terminated state
    _debouncing = Timer(const Duration(milliseconds: 500), () async {
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        await messagesHandling(context, initialMessage);
      }
      FirebaseMessaging.onMessage.listen((onMessageNotifyMe) async {
        await messagesHandling(context, onMessageNotifyMe);
      });
    });

    /// When is in bacground state
    _debouncing = Timer(const Duration(milliseconds: 500), () async {
      FirebaseMessaging.onMessageOpenedApp
          .listen((onMessageOpenedAppNotifyMe) async {
        await messagesHandling(context, onMessageOpenedAppNotifyMe);
      });
    });
  }

  Future<void> showNotification(
      {required String title, required String body}) async {
    AndroidNotificationChannel androidNotificationChannel =
        const AndroidNotificationChannel(
            'high_importance_channel', 'Highly important notifications',
            importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(androidNotificationChannel.id.toString(),
            androidNotificationChannel.name.toString(),
            channelDescription: 'Fec school App channel name',
            importance: Importance.max,
            priority: Priority.high);
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0, title, body, notificationDetails);
    });
  }
}

bool _isNavigatie = false;

Future<void> messagesHandling(
    BuildContext context, RemoteMessage? message) async {
  if (message == null || _isNavigatie) return;
  _isNavigatie = true;

  try {
    if (message.data['mtype'] == "notice") {
      List<Map<String, dynamic>> noticesList = await ApiService().getUsers();

      for (var singleNotice in noticesList) {
        if (singleNotice['id'].toString() == message.data['mid']) {
          if (!context.mounted) return;

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoticeTitle(
                mid: message.data['mid'],
                mtype: message.data['mtype'],
                id: singleNotice['id'],
                newNotice: singleNotice,
              ),
            ),
          );
          break;
        }
      }
    } else if (message.data['etype'] == "event") {
      List<Map<String, dynamic>> eventList = await EventsProvider().getsUsers();

      for (var singleEvent in eventList) {
        if (singleEvent['id'].toString() == message.data['eid']) {
          if (!context.mounted) return;

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventTitle(
                id: singleEvent['id'],
                eventsValue: singleEvent,
                eid: message.data['eid'],
                etype: message.data['etype'],
              ),
            ),
          );
          break;
        }
      }
    }
  } finally {
    _isNavigatie = false;
  }
}
