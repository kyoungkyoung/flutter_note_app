import 'package:flutter_note_app/domain/model/note.dart';
import 'package:sqflite/sqflite.dart';

class NoteDataSource {
  Database db;

  NoteDataSource(this.db);

  Future<void> insertNote(Note note) async {
    await db.insert('note', note.toJson());
  }

  Future<void> updateNote(Note note) async {
    // await db.update('note', note.toJson());
    await db.update('note', note.toJson(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<void> deleteNote(Note note) async {
    // await db.rawQuery('delete from note where id = ${note.id}');
    await db.delete('note', where: 'id = ?', whereArgs: [note.id]);
  }

  Future<List<Note>> getNotes() async {
    List<Map<String, dynamic>> maps =  await db.query('note');
    return maps.map((e) => Note.fromJson(e)).toList();
  }
  Future<Note?> getNoteById(int id) async {
    List<Map<String, dynamic>> maps = await db.query('note', where: 'id = ?', whereArgs: [id]);
      if(maps.isNotEmpty){
        return Note.fromJson(maps[0]);
      }
      return null;
  }
}