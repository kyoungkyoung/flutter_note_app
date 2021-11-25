import 'package:flutter/material.dart';
import 'package:flutter_note_app/core/data_case.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/use_case/note_use_cases.dart';
import 'package:flutter_note_app/presentation/notes/notes_event.dart';
import 'package:flutter_note_app/presentation/notes/notes_state.dart';

class NotesViewModel with ChangeNotifier {
  final NoteUseCases _noteUseCases;
  NoteUseCases get noteUseCases => _noteUseCases;

  NotesState _state = NotesState();
  NotesState get state => _state;

  Note? recentlyDeletedNote;

  NotesViewModel(this._noteUseCases) {
    _loadNotes();
  }

  void onEvent(NotesEvent event) {
    event.when(
      deleteNote: _deleteNote,
      restoreNote: _restoreNote,
      loadNotes: _loadNotes,
    );
  }

  void _loadNotes() async {
    // List<Note> notes = await getNotesUseCase.call(NoParams());
    List<Note> notes = await _noteUseCases.getNotesUseCase(state.noteOrder);
    _state = state.copyWith(
      notes: notes,
    );
    notifyListeners();
  }

  void _deleteNote(Note note) async {
    await _noteUseCases.deleteNoteUseCase.call(note);
    recentlyDeletedNote = note;

    _loadNotes();
  }

  void _restoreNote() async {
    if(recentlyDeletedNote != null){
      await _noteUseCases.addNoteUseCase(recentlyDeletedNote!);
      recentlyDeletedNote = null;
    }
    _loadNotes();
  }
}
