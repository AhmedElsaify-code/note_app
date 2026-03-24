import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_app/core/note_hive_helper.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  void getNotes() async {
    emit(NoteLoadingState());
    await NoteHiveHelper.getAllNotes();
    emit(NoteSuccessState());
  }

  void deleteAllNotes() {
    NoteHiveHelper.deleteAllNotes();
    emit(NoteSuccessState());
  }

  void addNote(String text) {
    NoteHiveHelper.addNote(text);
    emit(NoteSuccessState());
  }

  void updateNote(String text, int index) {
    NoteHiveHelper.updateNote(text, index);
    emit(NoteSuccessState());
  }

  void deleteNote(int index) {
    NoteHiveHelper.deleteNote(index);
    emit(NoteSuccessState());
  }
}
