import 'package:flutter/material.dart';
import 'package:flutter_note_app/core/data_case.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/use_case/delete_note_use_case.dart';
import 'package:flutter_note_app/domain/use_case/get_notes_use_case.dart';
import 'package:flutter_note_app/domain/use_case/note_use_cases.dart';
import 'package:flutter_note_app/presentation/notes/notes_event.dart';
import 'package:flutter_note_app/presentation/notes/notes_state.dart';

class NotesViewModel with ChangeNotifier {
  NoteUseCases noteUseCases;

  NotesState _state = NotesState();

  NotesState get state => _state;

  NotesViewModel(this.noteUseCases);

  void onEvent(NotesEvent event) {
    event.when(
      loadNotes: _loadNotes,
      deleteNote: _deleteNote,
      restoreNote: _restoreNote,
    );
  }

  void _loadNotes() async {
    // List<Note> notes = await getNotesUseCase.call(NoParams());
    List<Note> notes = await noteUseCases.getNotesUseCase(NoParams());
    _state = state.copyWith(
      notes: notes,
    );
    notifyListeners();
  }

  void _deleteNote(Note note) async {
    await noteUseCases.deleteNoteUseCase.call(note);
  }

  void _restoreNote() async {

  }
}
