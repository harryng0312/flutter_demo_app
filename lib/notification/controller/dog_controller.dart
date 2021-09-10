import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
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

  // constructors
  DogController({required this.state}) {
    _txtSearchCtr = TextEditingController();
    _pnlResultKey = GlobalKey();
  }

  // properties
  // List<Dog> get lsDataDog => _lsDog;
  List<Dog> get lsSearchDog => _lsSearchDog;

  TextEditingController get txtSearchCtr => _txtSearchCtr;

  GlobalKey get pnlResultKey => _pnlResultKey;

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
    // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin(); // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // var initializationSettingsAndroid =
    // new AndroidInitializationSettings('app_icon');
    // var initializationSettingsIOS = IOSInitializationSettings(
    //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    // var initializationSettings = InitializationSettings(
    //     initializationSettingsAndroid, initializationSettingsIOS);
    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: onSelectNotification);
    state.setState(() {
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
