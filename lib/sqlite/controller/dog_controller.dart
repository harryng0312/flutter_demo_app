import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:learning_flutter/sqlite/model/dog.dart';
import 'package:learning_flutter/sqlite/util/sqlite_util.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

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
    SqliteUtil sqliteUtil = Provider.of<SqliteUtil>(context, listen: false);
    sqliteUtil
        .openDb()
        .then((db) => sqliteUtil.selectDog(db, true, "", true))
        .then((value) => rs = value[1] as List<Dog>)
        .whenComplete(() {
      sqliteUtil.closeDb();
      pnlResultKey.currentState!.setState(() {
        txtSearchCtr.clear();
        lsSearchDog.clear();
        lsSearchDog.addAll(rs);
        print("List of dog size:${lsSearchDog.length}");
      });
    });
  }

  void searchDogHandler(String keyWord) {
    // List<Dog> result = [];
    List<Dog> rs = List.empty(growable: false);
    if (keyWord.isNotEmpty) {
      // rs = lsDataDog
      //     .where((element) =>
      //         element.name.toLowerCase().contains(keyWord.toLowerCase()))
      //     .toList();
      SqliteUtil sqliteUtil = Provider.of<SqliteUtil>(context, listen: false);
      sqliteUtil
          .openDb()
          .then((db) => sqliteUtil.selectDog(db, false, keyWord, true))
          .then((value) => rs = value[1] as List<Dog>)
          .whenComplete(() {
        sqliteUtil.closeDb();
        pnlResultKey.currentState!.setState(() {
          lsSearchDog.clear();
          lsSearchDog.addAll(rs);
        });
      });
    }
  }

  void addDogHandler() {
    // add a new Dog
    int id = DateTime.now().millisecondsSinceEpoch;
    String name = lorem(paragraphs: 1, words: 1);
    Random rand = Random();
    int age = rand.nextInt(100);
    Dog dog = Dog(id: id, name: name, age: age);
    // lsDataDog.add(dog);
    SqliteUtil sqliteUtil = Provider.of<SqliteUtil>(context, listen: false);
    sqliteUtil
        .openDb()
        .then((db) => sqliteUtil.insertDog(db, dog))
        .whenComplete(() {
      sqliteUtil.closeDb();
      // remove search value
      state.setState(() {
        refreshDataHandler();
      });
    });
  }

  void editDogHandler() {}

  void removeDogHandler() {
    // if (lsDataDog.length > 0) {
    txtSearchCtr.clear();
    // lsDataDog.removeLast();
    SqliteUtil sqliteUtil = Provider.of<SqliteUtil>(context, listen: false);
    sqliteUtil
        .openDb()
        .then((db) => sqliteUtil.selectDogMinId(db))
        .then((value) {
      Database db = value[0] as Database;
      Future<List<dynamic>> rs = Future.value([db, 0]);
      Dog? dog = value[1] as Dog?;
      if (dog != null) {
        rs = sqliteUtil.deleteDog(db, dog.id);
      }
      return rs;
    }).whenComplete(() {
      sqliteUtil.closeDb();
      refreshDataHandler();
    });
  }
}
