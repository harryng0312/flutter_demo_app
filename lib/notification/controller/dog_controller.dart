import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:learning_flutter/notification/util/notification_util.dart';
import 'package:learning_flutter/write_file/model/dog.dart';
import 'package:learning_flutter/notification/util/file_storage_util.dart';
import 'package:provider/provider.dart';

class DogController {
  // fields
  late BuildContext context;
  State state;

  // List<Dog> _lsDog = [];
  List<Dog> _lsSearchDog = [];
  late TextEditingController _txtSearchCtr;
  late GlobalKey _pnlResultKey;

  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  // late BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject;
  // constructors
  DogController({required this.state});

  void init() {
    _txtSearchCtr = TextEditingController();
    _pnlResultKey = GlobalKey();
  }

  void dispose() {}

  // properties
  // List<Dog> get lsDataDog => _lsDog;
  List<Dog> get lsSearchDog => _lsSearchDog;

  TextEditingController get txtSearchCtr => _txtSearchCtr;

  GlobalKey get pnlResultKey => _pnlResultKey;

  NotificationUtil get notificationUtil {
    return Provider.of<NotificationUtil>(context, listen: false);
  }

  // handlers
  void refreshDataHandler() {
    List<Dog> rs = [];
    FileStorageUtil fileStorageUtil =
        Provider.of<FileStorageUtil>(context, listen: false);
    fileStorageUtil
        .openFile()
        .then((db) => fileStorageUtil.selectDog(true, "", true))
        .then((value) => rs = value)
        .whenComplete(() {
      fileStorageUtil.closeFile();
      pnlResultKey.currentState!.setState(() {
        txtSearchCtr.clear();
        lsSearchDog.clear();
        lsSearchDog.addAll(rs);
        // print("List of dog size:${lsSearchDog.length}");
      });
    });
  }

  void searchDogHandler(String keyWord) {
    // List<Dog> result = [];
    List<Dog> rs = List.empty(growable: false);
    if (keyWord.isNotEmpty) {
      FileStorageUtil fileStorageUtil =
          Provider.of<FileStorageUtil>(context, listen: false);
      fileStorageUtil
          .openFile()
          .then((db) => fileStorageUtil.selectDog(false, keyWord, true))
          .then((value) => rs = value)
          .whenComplete(() {
        fileStorageUtil.closeFile();
        pnlResultKey.currentState!.setState(() {
          lsSearchDog.clear();
          lsSearchDog.addAll(rs);
        });
      });
    }
  }

  void addDogHandler() {
    // remove search value
    String body = lorem(paragraphs: 1, words: 1);
    NotificationDetails? notificationDetails =
        notificationUtil.createNotificationDetail();
    state.setState(() {
      notificationUtil.localNotification
          .show(0, "Title", body, notificationDetails, payload: "payload");
      txtSearchCtr.clear();
      refreshDataHandler();
    });
  }

  void editDogHandler() {}

  void removeDogHandler() {
    state.setState(() {
      txtSearchCtr.clear();
      refreshDataHandler();
    });
  }
}
