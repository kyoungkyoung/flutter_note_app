import 'package:flutter_note_app/core/data_case.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';
import 'package:flutter_note_app/domain/util/note_order.dart';

class GetNotesUseCase extends UseCase<List<Note>, NoteOrder> {
  //기능들은 전부 repository에 담아놓고 repository를 가져온다
  NoteRepository repository;

  GetNotesUseCase(this.repository);

  @override
  Future<List<Note>> call(NoteOrder noteOrder) async {
    List<Note> noteList = await repository.getNotes();

    // 정렬
    noteOrder.when(
      title: (orderType) {
        orderType.when(
          ascending: () {
            noteList = noteList..sort((Note a, Note b) => a.title.compareTo(b.title));
          },
          descending: () {
            noteList = noteList..sort((Note a, Note b) => b.title.compareTo(a.title));
          },
        );
      },
      date: (orderType) {
        orderType.when(
          ascending: () {
            noteList = noteList..sort((Note a, Note b) => a.timestamp.compareTo(b.timestamp));
          },
          descending: () {
            noteList = noteList..sort((Note a, Note b) => b.timestamp.compareTo(a.timestamp));
          },
        );
      },
      color: (orderType) {
        orderType.when(
          ascending: () {
            noteList = noteList..sort((Note a, Note b) => a.color.compareTo(b.color));
          },
          descending: () {
            noteList = noteList..sort((Note a, Note b) => b.color.compareTo(a.color));
          },
        );
      },
    );

    return noteList;
  }
}
