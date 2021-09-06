import 'dart:async';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learning_flutter/sqlite/model/dog.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteUtil {
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

  // Future<Database> _initDb() {
  //   // Avoid errors caused by flutter upgrade.
  //   // Importing 'package:flutter/widgets.dart' is required.
  //   WidgetsFlutterBinding.ensureInitialized();
  //   // String dbPath ="";
  //   this.database = getDatabasesPath().then((path) {
  //     print("Database path:${path}");
  //     Future<Database> db = openDatabase(
  //       // Set the path to the database. Note: Using the `join` function from the
  //       // `path` package is best practice to ensure the path is correctly
  //       // constructed for each platform.
  //       join(path, 'doggie_database.db'),
  //       // When the database is first created, create a table to store dogs.
  //       onCreate: createDb,
  //       // Set the version. This executes the onCreate function and provides a
  //       // path to perform database upgrades and downgrades.
  //       version: 1,
  //     );
  //     return db;
  //   });
  //   // database = openDatabase(
  //   //   // Set the path to the database. Note: Using the `join` function from the
  //   //   // `path` package is best practice to ensure the path is correctly
  //   //   // constructed for each platform.
  //   //   join(dbPath, 'doggie_database.db'),
  //   //   // When the database is first created, create a table to store dogs.
  //   //   onCreate: createDb,
  //   //   // Set the version. This executes the onCreate function and provides a
  //   //   // path to perform database upgrades and downgrades.
  //   //   version: 1,
  //   // );
  //   return database;
  // }

  Future<Database> _initDbAsync() async {
    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();
    this.database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'doggie_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return database;
  }

  Future<Database> openDb() {
    // return _initDb();
    return _initDbAsync();
  }

  Future<Database> closeDb() {
    return database.then((value) {
      if (value.isOpen) {
        value.close();
      }
      return database;
    });
  }

  Future<List<dynamic>> selectDog(
      Database db, bool isLoad, String nameKeyWord, bool sortByIdAsc) {
    // Future<List<Dog>> rs;
    Future<List<dynamic>> rs;
    if (isLoad) {
      rs = db
          .query("dogs", orderBy: "id ${sortByIdAsc ? 'asc' : 'desc'}")
          .then((value) {
        List<Dog> lsRs = [];
        value.forEach((element) {
          Dog d = Dog(
              id: element['id'] as int,
              name: element['name'] as String,
              age: element['age'] as int);
          lsRs.add(d);
          print("id:${d.id}\tname:${d.name}");
        });
        return [db, lsRs];
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
        return [db, lsRs];
      });
    }
    return rs;
  }

  Future<List<dynamic>> selectDogMinId(Database db) {
    Future<List<dynamic>> rs;
    rs = db.query("dogs", orderBy: "id ASC", limit: 1).then((resultSet) {
      Dog? rs;
      resultSet.forEach((element) {
        rs = Dog(
            id: element['id'] as int,
            name: element['name'] as String,
            age: element['age'] as int);
      });
      return [db, rs];
    });
    return rs;
  }

  Future<List<dynamic>> insertDog(Database db, Dog dog) async {
    Future<List<dynamic>> rs = db
        .insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    )
        .then((value) {
      // print("Insert dog: ${value}");
      return [db, value];
    });
    // .then((value){
    //   return selectDog(db, true, "", true);
    // });
    return rs;
  }

  Future<List<dynamic>> updateDog(Database db, Dog dog) {
    Future<List<dynamic>> rs = db.update("dogs", dog.toMap(),
        where: "id = ?", whereArgs: [dog.id]).then((value) => [db, value]);
    return rs;
  }

  Future<List<dynamic>> deleteDog(Database db, int id) {
    Future<List<dynamic>> rs = db.delete("dogs",
        where: "id=?", whereArgs: [id]).then((value) => [db, value]);
    return rs;
  }
}
