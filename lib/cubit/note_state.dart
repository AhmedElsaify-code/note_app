part of 'note_cubit.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}

final class NoteSuccessState extends NoteState {}

final class NoteLoadingState extends NoteState {}