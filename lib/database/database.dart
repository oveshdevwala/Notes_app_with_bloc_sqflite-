import 'dart:async';

import 'package:notes_app_bloc_database/database/notesmodel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper {
// variables

  static const dbName = 'notesblocDb.dart';
  static const dbVersion = 1;
  static const dbTable = 'Notes';
  static const colId = 'id';
  static const colTitle = 'title';
  static const colDiscription = 'discription';

// privet construtor
  Databasehelper._();
  static Databasehelper instance = Databasehelper._();
// inilDb
  Database? db;

  Future<Database> inilDb() async {
    var docDirectory = await getApplicationDocumentsDirectory();
    var path = join(docDirectory.path, dbName);

    oncreate(Database db, int version) {
      var autoIncrimentType = "integer primary key autoincrement not null";
      var stringType = 'text not null';
      db.execute(''' 
CREATE TABLE $dbTable(
  $colId $autoIncrimentType,
  $colTitle $stringType,
  $colDiscription $stringType
  )
''');
    }

    return await openDatabase(path, version: dbVersion, onCreate: oncreate);
  }

// get db
  Future<Database> getDb() async {
    if (db != null) {
      return db!;
    } else {
      return inilDb();
    }
  }

// CRUD
  Future<bool> createNotes(NoteModel model) async {
    var db = await getDb();
    var rowEffected = await db.insert(dbTable, model.toMap());
    return rowEffected > 0;
  }

  Future<List<NoteModel>> fetchNotes() async {
    var db = await getDb();
    List<NoteModel> arrData = [];
    var data = await db.query(dbTable);
    for (Map<String, dynamic> eachmap in data) {
      var notemodel = NoteModel.fromMap(eachmap);
      arrData.add(notemodel);
    }
    return arrData;
  }

  Future<bool> update(NoteModel model) async {
    var db = await getDb();
    var rowEffected = await db.update(dbTable, model.toMap(),
        where: "$colId = ?", whereArgs: ["${model.modelId}"]);
    return rowEffected > 0;
  }

  Future<bool> deleteNotes(int id) async {

    Timer(const Duration(milliseconds: 500), () async {
    });
    var db = await getDb();
    var rowEffected =
        await db.delete(dbTable, where: '$colId = ?', whereArgs: [id]);
    return rowEffected > 0;
  }
}
