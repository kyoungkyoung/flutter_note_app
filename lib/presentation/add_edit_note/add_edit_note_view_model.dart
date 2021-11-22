import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/use_case/note_use_cases.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_ui_event.dart';
import 'package:flutter_note_app/ui/colors.dart';

class AddEditNoteViewModel with ChangeNotifier {
  NoteUseCases useCases;

  AddEditNoteViewModel(this.useCases);

  int _color = roseBud.value;

  final _eventController = StreamController<AddEditNoteUiEvent>();
  Stream<AddEditNoteUiEvent> get eventStream => _eventController.stream;

  void onEvent(AddEditNoteEvent event) {
    event.when(
      saveNote: _saveNote,
      changeColor: _changeColor,
    );
  }

  void _saveNote(int? id, String title, String content) async {
    if(title.isEmpty || content.isEmpty) {
      _eventController.add(const AddEditNoteUiEvent.showSnackBar('제목이나 내용을 입력해주세요'));
      return;
    }

    if (id == null) {
      await useCases.addNoteUseCase(
        Note(
            title: title,
            content: content,
            color: _color,
            timestamp: DateTime.now().millisecondsSinceEpoch),
      );
    } else {
      await useCases.updateNoteUseCase(
        Note(
            id: id,
            title: title,
            content: content,
            color: _color,
            timestamp: DateTime.now().millisecondsSinceEpoch),
      );
    }
    _eventController.add(const AddEditNoteUiEvent.saveNote());
  }

  void _changeColor(int color) {
    _color = color;
    notifyListeners();
  }
}
