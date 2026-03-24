import 'package:hive_flutter/hive_flutter.dart';

class NoteHiveHelper {
  static var box = 'Box';
  static var noteKey = "NoteKey";
  static List<String> notes = [];

  static void addNote(String newNote) {
    notes.add(newNote);
    Hive.box(box).put(noteKey, notes);
  }

  static void updateNote(String newNote, int i) {
    notes[i] = newNote;
    Hive.box(box).put(noteKey, notes);
  }

  static void deleteNote(int i) {
    notes.removeAt(i);
    Hive.box(box).put(noteKey, notes);
  }

  static void deleteAllNotes() {
    notes = [];
    Hive.box(box).put(noteKey, notes);
  }

  static Future getAllNotes() async {
    if (box.isNotEmpty && Hive.box(box).get(noteKey) != null) {
      notes = await Hive.box(box).get(noteKey);
    }
  }
}


///(1) add note
///(2) update note
///(3) delete note
///(4) delete All
///(5) get notes