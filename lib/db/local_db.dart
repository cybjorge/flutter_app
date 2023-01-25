import 'dart:developer';

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter_app/api/models/actor_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

/* source

https://medium.com/swlh/flutter-get-data-from-a-rest-api-and-save-locally-in-a-sqlite-database-9a9de5867939

 */

class LocalDB{
  static Database? _database;
  static final LocalDB db = LocalDB._();

  LocalDB._();

  Future<Database> get database async =>
       _database ??= await db_init();

  /*
  Future<Database> get database async{
    _database ??= await db_init();
    return _database;
  }

   */


  db_init() async{
    var path = "";
    if(kIsWeb){
      path = join('lib/db/','actors_database.db');
    }
    else{
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      path = join(documentsDirectory.path, 'actors_database.db');
    }
    //Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //final path = join(documentsDirectory.path, 'actors_database.db');
    log('init IS ON $path');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE Actors('
              'children TEXT,'
              'country TEXT,'
              'description TEXT,'
              'dob TEXT,'
              'gender TEXT,'
              'height TEXT,'
              'image TEXT,'
              'name TEXT,'
              'spouse TEXT,'
              'wiki TEXT'
              ')');
        });
  }

  createActor(Actor actor) async {
    await deleteAllActors();
    final db = await LocalDB.db.database;
    final res = await db.insert('Actors', actor.toJson());

    return res;
  }

  // Delete all Actors
  Future<int> deleteAllActors() async {
    final db = await LocalDB.db.database;
    final res = await db.rawDelete('DELETE FROM Actors');

    return res;
  }

  Future<List<Actor>> getAllActors() async {
    final db = await LocalDB.db.database;
    final res = await db.rawQuery("SELECT rowid, * FROM Actors");

    List<Actor> list =
    res.isNotEmpty ? res.map((c) => Actor.fromJson(c)).toList() : [];

    return list;
  }

  Future<Actor> getActor(String name) async{
    final db = await LocalDB.db.database;
    final res = await db.rawQuery("SELECT * FROM Actors WHERE name=$name");

    Actor selected = res.map((c) => Actor.fromJson(c)) as Actor;

    return selected;
  }
}