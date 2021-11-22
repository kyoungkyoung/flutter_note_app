import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/use_case/note_use_cases.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_ui_event.dart';
import 'package:flutter_note_app/ui/colors.dart';

class AddEditNoteViewModel with ChangeNotifier {
  NoteUseCases useCases;

  AddEditNoteViewModel(this.useCases);

  int _color = roseBud.value;
  int get color => _color;

  Color _outline = Colors.transparent;
  Color get outline => _outline;

  // 단일 구독 스트림 : 해당 스트림의 전체 수명동안 단일 수신기만 허용 ; 처음 구독이 취소된후 stream을 재청취하는것은 불가능
  // final _eventController = StreamController<AddEditNoteUiEvent>();

  // 브로드캐스트 스트림 : 여러 청취자를 허용
  final _eventController = StreamController<AddEditNoteUiEvent>.broadcast();
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
    _outline = Colors.white;
    _color = color;
    notifyListeners();
  }
}
