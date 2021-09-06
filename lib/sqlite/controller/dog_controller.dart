import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:learning_flutter/sqlite/model/dog.dart';
import 'package:learning_flutter/sqlite/util/sqlite_util.dart';
import 'package:provider/provider.dart';

class DogController {
  // fields
  late BuildContext context;
  // List<Dog> _lsDog = [];
  List<Dog> _lsSearchDog = [];
  late TextEditingController _txtSearchCtr;
  late GlobalKey _pnlResultKey;

  // constructors
  DogController() {
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
    pnlResultKey.currentState!.setState(() {
      txtSearchCtr.clear();
      lsSearchDog.clear();
      SqliteUtil sqliteUtil = Provider.of<SqliteUtil>(context, listen: false);
      List<Dog> rs = [];
      sqliteUtil.selectDog(true, "", true).then((value) => rs = value);
      lsSearchDog.addAll(rs);
      // lsSearchDog.addAll(lsDataDog);
    });
  }

  void searchDogHandler(String keyWord) {
    // List<Dog> result = [];
    List<Dog> rs = List.empty(growable: false);
    pnlResultKey.currentState!.setState(() {
      if (keyWord.isNotEmpty) {
        // rs = lsDataDog
        //     .where((element) =>
        //         element.name.toLowerCase().contains(keyWord.toLowerCase()))
        //     .toList();
        SqliteUtil sqliteUtil = Provider.of<SqliteUtil>(context, listen: false);
        sqliteUtil.selectDog(false, keyWord, true).then((value) => rs = value);
      }
      lsSearchDog.clear();
      lsSearchDog.addAll(rs);
    });
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
    sqliteUtil.insertDog(dog);
  }

  void editDogHandler() {}

  void removeDogHandler() {
    // if (lsDataDog.length > 0) {
      txtSearchCtr.clear();
      // lsDataDog.removeLast();
      SqliteUtil sqliteUtil = Provider.of<SqliteUtil>(context, listen: false);
      Future<int> rs = sqliteUtil.selectDogMaxId().then((value) {
        Future<int> rs = Future.value(0);
        if(value!=null) {
          rs = sqliteUtil.deleteDog(value.id);
        }
        return rs;
      });
      refreshDataHandler();
    // }
  }
}
