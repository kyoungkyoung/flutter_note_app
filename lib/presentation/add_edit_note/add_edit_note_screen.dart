import 'package:flutter/material.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:flutter_note_app/ui/colors.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class AddEditNoteScreen extends StatefulWidget {
  // Note? note;

  const AddEditNoteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final _colors = [
    roseBud.value,
    primrose.value,
    wisteria.value,
    skyBlue.value,
    illusion.value,
  ];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final viewModel = context.read<AddEditNoteViewModel>();
      viewModel.eventStream.listen((event) {
        event.when(
            saveNote: () {},
            showSnackBar: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            });
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddEditNoteViewModel>();

    return Scaffold(
      body: SafeArea(
        child: AnimatedContainer(
          color: Color(viewModel.color),
          duration: const Duration(milliseconds: 300),
          child: ListView(
            padding: const EdgeInsets.only(top: 8.0),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // InkWell(
                    //   child: Container(
                    //     padding: EdgeInsets.all(3.0),
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         shape: BoxShape.circle,
                    //         boxShadow: [
                    //           BoxShadow(blurRadius: 5, color: Colors.white)
                    //         ]),
                    //     child: colorMaterialButton(roseBud.value),
                    //   ),
                    //   onTap: () {},
                    // ),
                    colorMaterialButton(roseBud.value),
                    colorMaterialButton(primrose.value),
                    colorMaterialButton(wisteria.value),
                    colorMaterialButton(skyBlue.value),
                    colorMaterialButton(illusion.value),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _titleController,
                      style: const TextStyle(fontSize: 40),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _contentController,
                      style: const TextStyle(fontSize: 25),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'content',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.onEvent(
            AddEditNoteEvent.saveNote(
              // widget.note?.id,
              null,
              _titleController.text,
              _contentController.text,
            ),
          );
        },
        child: const Icon(Icons.save),
        backgroundColor: const Color(0xFF25CBA5),
      ),
    );
  }

  Widget colorMaterialButton(int color) {
    return Expanded(
      child: MaterialButton(
        height: 50,
        shape:
            const CircleBorder(side: BorderSide(color: Colors.white, width: 1)),
        elevation: 8,
        color: Color(color),
        onPressed: () {
          final viewModel = context.read<AddEditNoteViewModel>();
          viewModel.onEvent(AddEditNoteEvent.changeColor(color));
        },
      ),
    );
  }
}
