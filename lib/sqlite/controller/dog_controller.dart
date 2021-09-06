import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:learning_flutter/sqlite/model/dog.dart';

class DogController {
  late BuildContext context;
  List<Dog> _lsDog = [];
  List<Dog> _lsSearchDog = [];
  late TextEditingController _txtSearchCtr;
  late GlobalKey _pnlResultKey;

  DogController() {
    _txtSearchCtr = TextEditingController();
    _pnlResultKey = GlobalKey();
  }

  List<Dog> get lsDataDog {
    return _lsDog;
  }

  List<Dog> get lsSearchDog {
    return _lsSearchDog;
  }

  TextEditingController get txtSearchCtr => _txtSearchCtr;

  GlobalKey get pnlResultKey => _pnlResultKey;

  void refreshData() {
    pnlResultKey.currentState!.setState(() {
      txtSearchCtr.clear();
      lsSearchDog.clear();
      lsSearchDog.addAll(lsDataDog);
    });
  }

  List<Dog> searchDog(String keyWord) {
    List<Dog> result = [];
    List<Dog> rs = List.empty(growable: false);
    pnlResultKey.currentState!.setState(() {
      if (keyWord.isNotEmpty) {
        rs = lsDataDog
            .where((element) =>
                element.name.toLowerCase().contains(keyWord.toLowerCase()))
            .toList();
      }
      lsSearchDog.clear();
      lsSearchDog.addAll(rs);
    });
    return result;
  }

  void addDogHandler() {
    // add a new Dog
    int id = DateTime.now().millisecondsSinceEpoch;
    String name = lorem(paragraphs: 1, words: 1);
    Random rand = Random();
    int age = rand.nextInt(100);
    Dog dog = Dog(id: id, name: name, age: age);
    lsDataDog.add(dog);
    refreshData();
  }

  void editDogHandler() {}

  void removeDogHandler() {
    if (lsDataDog.length > 0) {
      txtSearchCtr.clear();
      lsDataDog.removeLast();
      refreshData();
    }
  }
}
