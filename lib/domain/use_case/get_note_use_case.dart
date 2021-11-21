import 'package:flutter_note_app/core/data_case.dart';
import 'package:flutter_note_app/core/result.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';

class GetNoteUseCase extends UseCase<Result<Note>, int> {
  NoteRepository repository;

  GetNoteUseCase(this.repository);

  @override
  Future<Result<Note>> call(int id) async {
    Result<Note> note = await repository.getNoteById(id);
    return note;
  }

}