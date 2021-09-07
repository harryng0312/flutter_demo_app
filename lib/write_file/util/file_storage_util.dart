import 'dart:convert';
import 'dart:io';
import 'package:learning_flutter/write_file/model/dog.dart';
import 'package:path_provider/path_provider.dart' as Path;

class FileStorageUtil {
  // late Future<RandomAccessFile> _futureRaf;
  late String filePathName = "";

  FileStorageUtil();

  factory FileStorageUtil.getInstance() {
    return FileStorageUtil();
  }

  Future<int> openFile() async {
    Directory directory = await Path.getApplicationDocumentsDirectory();
    filePathName = "${directory.path}/dog.json";
    // _futureRaf = file.open(mode: FileMode.write);
    Future<int> rs = Future.value(0);
    File file = File(filePathName);
    Future<bool> fExisted = Future.sync(() => file.exists());
    Future<int> fLength = Future.sync(() => file.length());
    if (!await fExisted || await fLength <= 0) {
      file = await file.create();
      rs = file.writeAsString("[]").then((value) => 1);
    }
    return rs;
  }

  Future<int> closeFile() {
    return Future.value(0);
  }

  Future<List<Dog>> selectDog(
      bool isLoad, String nameKeyWord, bool sortByIdAsc) async {
    File file = File(filePathName);
    Future<List<Dog>> rs = Future.value(<Dog>[]);
    String content = await file.readAsString();
    Iterable ite = jsonDecode(content);
    List<Dog> lsDog = List<Dog>.from(ite.map((e) => Dog.fromJson(e)));
    lsDog.sort((a, b) => a.id.compareTo(b.id));
    if (isLoad) {
      rs = Future.value(lsDog);
    } else {
      rs = Future.value(List<Dog>.from(lsDog.where((element) =>
          element.name.toLowerCase().contains(nameKeyWord.toLowerCase()))));
    }
    return rs;
  }

  Future<Dog?> selectDogMinId() async {
    List<Dog> lsDog = await selectDog(true, "", true);
    Dog? rs;
    if (lsDog.isNotEmpty) {
      rs = lsDog.first;
    }
    return rs;
  }

  Future<int> insertDog(Dog dog) async {
    List<Dog> lsDog = await selectDog(true, "", true);
    lsDog.add(dog);
    File file = File(filePathName);
    String contents = jsonEncode(lsDog);
    Future<int> rs = file.writeAsString(contents).then((value) => 1);
    return rs;
  }

  Future<int> updateDog(Dog dog) async {
    List<Dog> lsDog = await selectDog(true, "", true);
    Future<int> rs = Future.value(0);
    Dog dogCurr;
    dogCurr = lsDog.firstWhere((e) => e.id == dog.id,
        orElse: () => Dog(id: 0, name: "", age: 0));
    if (dogCurr.id > 0) {
      dogCurr.name = dog.name;
      dogCurr.age = dog.age;
      File file = File(filePathName);
      String contents = jsonEncode(lsDog);
      rs = file.writeAsString(contents).then((value) => 1);
    }
    return rs;
  }

  Future<int> deleteDog(int id) async {
    List<Dog> lsDog = await selectDog(true, "", true);
    int beforeRemoveSize = lsDog.length;
    Future<int> rs = Future.value(0);
    lsDog.removeWhere((element) => element.id == id);
    int afterRemoveSize = lsDog.length;
    if (beforeRemoveSize > afterRemoveSize) {
      File file = File(filePathName);
      String contents = jsonEncode(lsDog);
      rs = file.writeAsString(contents).then((value) => 1);
    }
    return rs;
  }
}
