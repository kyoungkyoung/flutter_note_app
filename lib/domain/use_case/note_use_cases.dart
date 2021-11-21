import 'package:flutter_note_app/domain/use_case/add_note_use_case.dart';
import 'package:flutter_note_app/domain/use_case/delete_note_use_case.dart';
import 'package:flutter_note_app/domain/use_case/get_note_use_case.dart';
import 'package:flutter_note_app/domain/use_case/get_notes_use_case.dart';
import 'package:flutter_note_app/domain/use_case/update_note_use_case.dart';

class NoteUseCases {
  AddNoteUseCase addNoteUseCase;
  UpdateNoteUseCase updateNoteUseCase;
  DeleteNoteUseCase deleteNoteUseCase;
  GetNoteUseCase getNoteUseCase;
  GetNotesUseCase getNotesUseCase;

  NoteUseCases({
    required this.addNoteUseCase,
    required this.updateNoteUseCase,
    required this.deleteNoteUseCase,
    required this.getNoteUseCase,
    required this.getNotesUseCase
  });
}
