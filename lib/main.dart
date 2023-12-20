import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_bloc_database/bloc/notes_bloc.dart';
import 'package:notes_app_bloc_database/database/database.dart';
import 'package:notes_app_bloc_database/screens/home.dart';

void main() {
  runApp(BlocProvider<NotesBloc>(
    create: (context) => NotesBloc(db: Databasehelper.instance),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
