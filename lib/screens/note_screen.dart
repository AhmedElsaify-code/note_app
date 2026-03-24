import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:note_app/cubit/note_cubit.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({
    super.key,
    required this.appbar,
    required this.controller,
    required this.oper,
    this.index
  });
  final TextEditingController controller;
  final String appbar;
  final operation oper;
  final int? index;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        toolbarHeight: 100,
        title: Text(
          appbar,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            SizedBox(
              height: double.infinity,
              child: TextFormField(
                controller: controller,
                style: TextStyle(fontSize: 18),
                maxLength: 10000,
                maxLines: 1000,
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  if (oper == operation.add) {
                    cubit.addNote(controller.text);
                  } else {
                    cubit.updateNote(controller.text, index!);
                  }
                }
                Get.back();
              },

              backgroundColor: Colors.green,
              child: Icon(Icons.done, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

enum operation { add, update }
