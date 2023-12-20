// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_bloc_database/bloc/notes_bloc.dart';
import 'package:notes_app_bloc_database/bloc/notes_event.dart';
import 'package:notes_app_bloc_database/database/colors.dart';
import 'package:notes_app_bloc_database/screens/home.dart';

class AddNotesScreen extends StatelessWidget {
  AddNotesScreen(
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
    if (isUpdate) {
      context.read<NotesBloc>().add(UpdateTextField(title: title, disc: disc));
    }
    return Scaffold(
      backgroundColor: UiColors.shade100,
      appBar: AppBar(
          backgroundColor: UiColors.shade100,
          actions: [
            TextButton(
                onPressed: () {
                  if (isUpdate) {
                    context.read<NotesBloc>().add(UpdateNotesEvent(id: mid));
                  } else {
                    context.read<NotesBloc>().add(CreateNotesEvent());
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: UiColors.shade700),
                )),
            const SizedBox(
              width: 20,
            )
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.back,
                color: UiColors.shade700,
              ))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: context.read<NotesBloc>().titleController,
              minLines: 1,
              maxLines: 5,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: UiColors.black),
              decoration: const InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
            TextField(
              controller: context.read<NotesBloc>().discController,
              minLines: 5,
              maxLines: 100,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: UiColors.blac38),
              decoration: const InputDecoration(
                  hintText: 'Discription',
                  hintStyle: TextStyle(fontSize: 14),
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ],
        ),
      ),
    );
  }
}
