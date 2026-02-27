import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubit/cubit/note_cubit.dart';
import 'package:note_app/note_hive_helper.dart';

class HomeScreenState extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  HomeScreenState({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteCubit>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'Notepad',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              AlertDialog alert = AlertDialog(
                title: Text("Delete All Notes"),
                content: Text('Are you sure?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      cubit.deleteAllNotes();
                      Navigator.pop(context);
                    },
                    child: Text("Yes"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                ],
              );

              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            },
            child: Text('Clear All', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          controller.clear();
          AlertDialog alert = AlertDialog(
            title: Text("Add Note"),
            content: TextField(controller: controller),
            actions: [
              TextButton(
                onPressed: () {
                  cubit.addNote(controller.text);
                  Navigator.pop(context);
                },
                child: Text("Add"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          );

          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body:
          ///ToDo : if condition => loading
          BlocBuilder<NoteCubit, NoteState>(
            builder: (context, state) {
               if (state is NoteLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
              return ListView.builder(
                itemCount: NoteHiveHelper.notes.length,
                itemBuilder: (context, i) => InkWell(
                  onTap: () async {
                    controller.text = NoteHiveHelper.notes[i];
                    AlertDialog alert = AlertDialog(
                      title: Text("Update Note"),
                      content: TextField(controller: controller),
                      actions: [
                        TextButton(
                          onPressed: () {
                            cubit.updateNote(controller.text, i);
                            Navigator.pop(context);
                          },
                          child: Text("Update"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                      ],
                    );

                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: i % 2 == 0
                              ? Colors.blue.withValues(alpha: .2)
                              : Colors.green.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            NoteHiveHelper.notes[i],
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: IconButton(
                          onPressed: () async {
                            AlertDialog alert = AlertDialog(
                              title: Text("Delete Note"),
                              content: Text('Are you sure?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    cubit.deleteNote(i);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel"),
                                ),
                              ],
                            );

                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          },
                          icon: Icon(
                            Icons.delete_forever,
                            color: Colors.black.withValues(alpha: 0.5),
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
