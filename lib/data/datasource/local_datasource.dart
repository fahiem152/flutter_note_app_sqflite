import 'package:note_app_sqflite/data/model/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatasource {
  final String dbName = 'notes_local01.db';
  final String tableName = 'notes';

  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(''' 
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT,
            createdAt TEXT)
      
        ''');
      },
    );
  }

  Future<int> insertNote(Note note) async {
    final db = await _openDatabase();
    return await db.insert(tableName, note.toMap());
  }

  Future<List<Note>> getNotes() async {
    final db = await _openDatabase();
    final maps = await db.query(tableName, orderBy: 'CreatedAt DESC');
    return List.generate(
      maps.length,
      (index) => Note.fromMap(
        maps[index],
      ),
    );
  }

  Future<int> updateNoteById(Note note) async {
    final db = await _openDatabase();
    return await db.update(
      tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNoteById(int id) async {
    final db = await _openDatabase();
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
