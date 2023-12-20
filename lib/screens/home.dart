// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_bloc_database/bloc/notes_bloc.dart';
import 'package:notes_app_bloc_database/bloc/notes_event.dart';
import 'package:notes_app_bloc_database/bloc/notes_state.dart';
import 'package:notes_app_bloc_database/database/colors.dart';
import 'package:notes_app_bloc_database/screens/addNote.dart';
import 'package:notes_app_bloc_database/screens/noteview.dart';

bool isUpdate = false;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    context.read<NotesBloc>().add(FetchNotesEvent());
    return Scaffold(
      backgroundColor: UiColors.shade100,
      floatingActionButton: FloatingActionButton(
        backgroundColor: UiColors.shade100,
        onPressed: () {
          isUpdate = false;
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddNotesScreen(
                index: 0,
                mid: 0,
                disc: '',
                title: '',
              );
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
          backgroundColor: UiColors.shade100,
          title: const Text('Bloc Notes App')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<NotesBloc, NotesState>(
              builder: (context, state) {
                if (state is NotesLoadingState) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }
                if (state is NotesErrorState) {
                  return Center(child: Text(state.errorMsg.toString()));
                }
                if (state is NotesLoadedState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotesViewScreen(
                                      index: index,
                                      disc: state.data[index].modelDescription,
                                      title: state.data[index].modelTitle,
                                      mid: state.data[index].modelId),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: UiColors.shade200,
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text(
                                    state.data[index].modelTitle,
                                    maxLines: 5,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
