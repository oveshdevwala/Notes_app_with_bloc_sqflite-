import 'package:notes_app_bloc_database/database/database.dart';

class NoteModel {
  // variable
  int modelId;
  String modelTitle;
  String modelDescription;

  // constructor
  NoteModel(
      {required this.modelId,
      required this.modelTitle,
      required this.modelDescription});
// fromMap
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
        modelId: map[Databasehelper.colId],
        modelTitle: map[Databasehelper.colTitle],
        modelDescription: map[Databasehelper.colDiscription]);
  }
//toMap
  Map<String, dynamic> toMap() {
    return {
      Databasehelper.colTitle: modelTitle,
      Databasehelper.colDiscription: modelDescription
    };
  }
}
