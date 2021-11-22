import 'package:flutter_note_app/data/data_source/local/note_data_source.dart';
import 'package:flutter_note_app/data/repository/note_repository_impl.dart';
import 'package:flutter_note_app/domain/use_case/add_note_use_case.dart';
import 'package:flutter_note_app/domain/use_case/delete_note_use_case.dart';
import 'package:flutter_note_app/domain/use_case/get_note_use_case.dart';
import 'package:flutter_note_app/domain/use_case/get_notes_use_case.dart';
import 'package:flutter_note_app/domain/use_case/note_use_cases.dart';
import 'package:flutter_note_app/domain/use_case/update_note_use_case.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:flutter_note_app/presentation/notes/notes_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sqflite/sqflite.dart';

Future<List<SingleChildWidget>> getProviders() async {
  final db = await openDatabase(
    'notes.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'create table note(id integer primary key autoincrement, title text, content text, color integer, timestamp integer)');
    },
  );

  final noteDataSource = NoteDataSource(db);
  final noteRepository = NoteRepositoryImpl(noteDataSource);
  final noteUseCases = NoteUseCases(
    addNoteUseCase: AddNoteUseCase(noteRepository),
    updateNoteUseCase: UpdateNoteUseCase(noteRepository),
    deleteNoteUseCase: DeleteNoteUseCase(noteRepository),
    getNoteUseCase: GetNoteUseCase(noteRepository),
    getNotesUseCase: GetNotesUseCase(noteRepository),
  );

  return [
    ChangeNotifierProvider<NotesViewModel>(
        create: (context) => NotesViewModel(noteUseCases)),
    ChangeNotifierProvider<AddEditNoteViewModel>(
        create: (context) => AddEditNoteViewModel(noteUseCases)),
  ];


}