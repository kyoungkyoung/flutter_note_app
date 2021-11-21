import 'package:flutter_note_app/core/result.dart';
import 'package:flutter_note_app/domain/model/note.dart';

abstract class NoteRepository {
  Future<void> insertNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(Note note);
  Future<List<Note>> getNotes();
  Future<Result<Note>> getNoteById(int id);
}