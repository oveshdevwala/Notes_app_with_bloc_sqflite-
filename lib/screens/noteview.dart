// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_bloc_database/bloc/notes_bloc.dart';
import 'package:notes_app_bloc_database/bloc/notes_event.dart';
import 'package:notes_app_bloc_database/bloc/notes_state.dart';
import 'package:notes_app_bloc_database/database/colors.dart';
import 'package:notes_app_bloc_database/screens/addNote.dart';
import 'package:notes_app_bloc_database/screens/home.dart';

class NotesViewScreen extends StatelessWidget {
  NotesViewScreen(
      {super.key,
      required this.index,
      required this.mid,
      required this.disc,
      required this.title});
  int index;
  int mid;
  String title;
  String disc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.shade100,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                isUpdate = true;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNotesScreen(
                        index: index,
                        title: title,
                        disc: disc,
                        mid: mid,
                      ),
                    ));
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<NotesBloc>().add(DeleteNotesEvent(id: mid));
              },
              icon: const Icon(Icons.delete))
        ],
        backgroundColor: UiColors.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              if (state is NotesLoadingState) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
              if (state is NotesErrorState) {
                return Center(child: Text(state.errorMsg.toString()));
              }
              if (state is NotesLoadedState) {
                return Column(
                  children: [
                    Text(
                      state.data[index].modelTitle.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      state.data[index].modelDescription.toString(),
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: UiColors.blac38),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
