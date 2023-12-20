abstract class NotesEvent {}

class CreateNotesEvent extends NotesEvent {}

class FetchNotesEvent extends NotesEvent {}

class UpdateNotesEvent extends NotesEvent {
  int id;
  UpdateNotesEvent({required this.id});
}

class DeleteNotesEvent extends NotesEvent {
  int id;
  DeleteNotesEvent({required this.id});
}

class UpdateTextField extends NotesEvent {
  String title;
  String disc;
  UpdateTextField({required this.title, required this.disc});
}
