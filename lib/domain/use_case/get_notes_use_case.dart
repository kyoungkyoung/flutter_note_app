import 'package:flutter_note_app/core/data_case.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';

class GetNotesUseCase extends UseCase<List<Note>, NoParams> {
  //기능들은 전부 repository에 담아놓고 repository를 가져온다
  NoteRepository repository;

  GetNotesUseCase(this.repository);

  @override
  Future<List<Note>> call(NoParams params) {
    return repository.getNotes();

  }

}