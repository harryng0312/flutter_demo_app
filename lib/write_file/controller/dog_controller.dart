import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:learning_flutter/write_file/model/dog.dart';
import 'package:learning_flutter/write_file/util/file_storage_util.dart';
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
    // add a new Dog
    int id = DateTime.now().millisecondsSinceEpoch;
    String name = lorem(paragraphs: 1, words: 1);
    Random rand = Random();
    int age = rand.nextInt(100);
    Dog dog = Dog(id: id, name: name, age: age);
    // lsDataDog.add(dog);
    FileStorageUtil fileStorageUtil =
        Provider.of<FileStorageUtil>(context, listen: false);
    fileStorageUtil
        .openFile()
        .then((db) => fileStorageUtil.insertDog(dog))
        .whenComplete(() {
      fileStorageUtil.closeFile();
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
    FileStorageUtil fileStorageUtil =
        Provider.of<FileStorageUtil>(context, listen: false);
    fileStorageUtil
        .openFile()
        .then((db) => fileStorageUtil.selectDogMinId())
        .then((value) {
      Future<int> rs = Future.value(0);
      Dog? dog = value;
      if (dog != null) {
        rs = fileStorageUtil.deleteDog(dog.id);
      }
      return rs;
    }).whenComplete(() {
      fileStorageUtil.closeFile();
      refreshDataHandler();
    });
  }
}
