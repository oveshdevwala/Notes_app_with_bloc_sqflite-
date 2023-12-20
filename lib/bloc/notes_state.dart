import 'package:notes_app_bloc_database/database/notesmodel.dart';

abstract class NotesState {}

class NotesInitialState extends NotesState {}

class NotesLoadingState extends NotesState {}

class NotesLoadedState extends NotesState {
  List<NoteModel> data;
  NotesLoadedState({required this.data});
}

class NotesErrorState extends NotesState {
  String errorMsg;
  NotesErrorState({required this.errorMsg});
}
