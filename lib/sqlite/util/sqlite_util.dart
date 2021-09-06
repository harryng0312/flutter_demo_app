import 'dart:async';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:learning_flutter/sqlite/model/dog.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteUtil{
  late Future<Database> database;

  SqliteUtil();

  factory SqliteUtil.getInstance() {
    return SqliteUtil();
  }

  FutureOr<void> createDb(Database db, int version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
      'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
    );
  }

  Future<Database> _initDb() async {
    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();
    String dbPath = await getDatabasesPath();
    print("Database path:${dbPath}");
    database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(dbPath, 'doggie_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: createDb,
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return database;
  }

  Future<Database> openDb() {
    return _initDb();
  }

  Future<Database> closeDb() {
    return database.then((value) {
      if (value.isOpen) {
        value.close();
      }
      return database;
    });
  }

  Future<List<Dog>> selectDog(
      bool isLoad, String nameKeyWord, bool sortByIdAsc) async {
    final db = await database;
    Future<List<Dog>> rs;
    if (isLoad) {
      rs = db
          .query("dogs", orderBy: "id ${sortByIdAsc ? 'asc' : 'desc'}")
          .then((value) {
        List<Dog> lsRs = [];
        value.forEach((element) {
          lsRs.add(Dog(
              id: element['id'] as int,
              name: element['name'] as String,
              age: element['age'] as int));
        });
        return lsRs;
      });
    } else {
      rs = db
          .query("dogs",
              where: "name like ?",
              whereArgs: ["%${nameKeyWord}%"],
              orderBy: "id ${sortByIdAsc ? 'asc' : 'desc'}")
          .then((value) {
        List<Dog> lsRs = [];
        value.forEach((element) {
          lsRs.add(Dog(
              id: element['id'] as int,
              name: element['name'] as String,
              age: element['age'] as int));
        });
        return lsRs;
      });
    }
    return rs;
  }

  Future<Dog?> selectDogMaxId() async {
    final db = await database;
    Future<Dog?> rs;
    rs = db.query("dogs", where: "id = max(id)").then((value) {
      Dog? rs;
      value.forEach((element) {
        rs = Dog(
            id: element['id'] as int,
            name: element['name'] as String,
            age: element['age'] as int);
      });
      return rs;
    });
    return rs;
  }

  Future<int> insertDog(Dog dog) async {
    final db = await database;
    return db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateDog(Dog dog) async {
    final db = await database;
    Future<int> rs =
        db.update("dogs", dog.toMap(), where: "id = ?", whereArgs: [dog.id]);
    return rs;
  }

  Future<int> deleteDog(int id) async {
    final db = await database;
    Future<int> rs = db.delete("dogs", where: "id=?", whereArgs: [id]);
    return rs;
  }
}
