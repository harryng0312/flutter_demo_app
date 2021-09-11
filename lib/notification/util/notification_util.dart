import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtil {
  late FlutterLocalNotificationsPlugin _localNotification;
  late FirebaseMessaging _fbm;

  NotificationUtil._() {
    init();
  }

  factory NotificationUtil.getInstance() {
    return NotificationUtil._();
  }

  FlutterLocalNotificationsPlugin get localNotification => _localNotification;

  _initLocal() {
    _localNotification = FlutterLocalNotificationsPlugin();
    // didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();
    _localNotification
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    _localNotification
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
    _localNotification.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      print("Payload[${payload!.length}]: ${payload}");
    });
  }

  _initRemote() {
    _fbm = FirebaseMessaging.instance;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // await Firebase.initializeApp();
      print('Got a message whilst in the openedapp!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    Future<NotificationSettings> fNotificationSettings =
        _fbm.requestPermission(alert: true, badge: true, sound: true);
    fNotificationSettings.then((setttings){

    });
  }

  init() {
    WidgetsFlutterBinding.ensureInitialized();
    _initLocal();
    // _initRemote();
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
