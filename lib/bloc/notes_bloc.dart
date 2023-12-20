import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_bloc_database/bloc/notes_event.dart';
import 'package:notes_app_bloc_database/bloc/notes_state.dart';
import 'package:notes_app_bloc_database/database/database.dart';
import 'package:notes_app_bloc_database/database/notesmodel.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  Databasehelper db;
  var titleController = TextEditingController();
  var discController = TextEditingController();
  NotesBloc({required this.db}) : super(NotesInitialState()) {
    on<CreateNotesEvent>(createNotesEvent);
    on<UpdateNotesEvent>(updateNotesEvent);
    on<UpdateTextField>(updateTextField);
    on<FetchNotesEvent>(fecthNotesEvent);
    on<DeleteNotesEvent>(deleteNotesEvent);
  }

  FutureOr<void> createNotesEvent(
      CreateNotesEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoadingState());
    var notemodel = NoteModel(
        modelId: 0,
        modelTitle: titleController.text.toString(),
        modelDescription: discController.text.toString());
    bool check = await db.createNotes(notemodel);
    if (check) {
      emit(NotesLoadedState(data: await db.fetchNotes()));
    } else {
      emit(NotesErrorState(errorMsg: 'Failed to Created'));
    }
  }

  FutureOr<void> updateNotesEvent(
      UpdateNotesEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoadingState());
    var notemodel = NoteModel(
        modelId: event.id,
        modelTitle: titleController.text.toString(),
        modelDescription: discController.text.toString());
    bool check = await db.update(notemodel);
    if (check) {
      emit(NotesLoadedState(data: await db.fetchNotes()));
    } else {
      emit(NotesErrorState(errorMsg: 'Failed to Updated'));
    }
  }

  FutureOr<void> fecthNotesEvent(
      FetchNotesEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoadingState());
    emit(NotesLoadedState(data: await db.fetchNotes()));
  }

  FutureOr<void> deleteNotesEvent(
      DeleteNotesEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoadingState());
    var check = true;
    check = await db.deleteNotes(event.id);
    if (check) {
      emit(NotesLoadedState(data: await db.fetchNotes()));
    } else {
      emit(NotesErrorState(errorMsg: 'Failed to Delete'));
    }
  }

  FutureOr<void> updateTextField(
      UpdateTextField event, Emitter<NotesState> emit) async {
    titleController.text = event.title;
    discController.text = event.disc;
    emit(NotesLoadedState(data: await db.fetchNotes()));
  }
}
