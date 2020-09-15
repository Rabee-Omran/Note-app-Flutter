import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqllite2/model/note.dart';

class DatabaseHelper {
  final String tableNote = 'noteTable';
  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnName = 'name';
  final String columnDescription = 'description';
  final String columnImage = 'image';


  static Database _db;

  Future<Database> get db async {

    _db = await initDB();
if (_db != null) return _db;
    return db;
  }

  initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'notes.db');
    await openDatabase(path, version: 6, onCreate: _onCreate,onUpgrade:_onUpgrade );
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    var sql = 'CREATE TABLE $tableNote ($columnId INTEGER PRIMARY KEY,'
        ' $columnTitle TEXT ,$columnName TEXT ,'
        ' $columnDescription TEXT )';
    await db.execute(sql);
    await db.execute("ALTER TABLE $tableNote ADD COLUMN image TEXT;");
  }
  void _onUpgrade(Database db, int oldVersion, int newVersion) async{
    if (oldVersion < newVersion) {
      await db.execute("ALTER TABLE $tableNote ADD COLUMN image TEXT;");
    }
  }
  Future<int> saveNote(Note note) async {
    var dbClient = await db;
    var result =await dbClient.insert(tableNote, note.toMap());
    return result;
  }

  Future<List> getAllNotes() async {
    var dbClient = await db;
    var result = await dbClient.query(tableNote,
        columns: [columnId, columnName, columnTitle, columnDescription, columnImage]);
    return result.toList();
  }


  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableNote'));
  }



  Future<Note> getEmployee(int id) async {
    var dbClient = await db;

    List<Map> result = await dbClient.query(tableNote,
        columns: [columnId, columnName, columnTitle, columnDescription, columnImage],
        where: "$columnId = ?",
        whereArgs: ['id']);
    if (result.length > 0) {
      return new Note.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateNote(Note note) async {
    var dbClient = await db;
    return await dbClient.update(tableNote, note.toMap(),
        where: "$columnId = ?", whereArgs: [note.id]);
  }

  Future<int> deleteNote(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableNote, where: "$columnId = ?", whereArgs: [id]);
  }

  Future close() async {
    var dbClient = await db;
    return await dbClient.close();
  }
}
