import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtil {
  late FlutterLocalNotificationsPlugin localNotification;

  NotificationUtil._(){init();}

  factory NotificationUtil.getInstance(){
    return NotificationUtil._();
  }

  init() {
    localNotification = FlutterLocalNotificationsPlugin();
    WidgetsFlutterBinding.ensureInitialized();
    localNotification = FlutterLocalNotificationsPlugin();
    // didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();
    localNotification
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    localNotification
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    // localNotification.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    // NotificationAppLaunchDetails? notificationAppLaunchDetails =
    //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    // android
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("app_icon");
    // iOS
    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {
              // didReceiveLocalNotificationSubject.add(ReceivedNotification(
              //   id: id,
              //   title: title,
              //   body: body,
              //   payload: payload,
              //   ),
            });
    // init
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    localNotification.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      print("Payload[${payload!.length}]: ${payload}");
    });
  }

  NotificationDetails createNotificationDetail() {
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
    IOSNotificationDetails(sound: 'slow_spring_board.aiff');
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      'your other channel description',
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
    );

    NotificationDetails notificationDetails = NotificationDetails(
      iOS: iOSPlatformChannelSpecifics,
      android: androidPlatformChannelSpecifics,
    );
    return notificationDetails;
  }
}
