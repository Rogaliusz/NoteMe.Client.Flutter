import 'package:injectable/injectable.dart';
import 'package:noteme/framework/sql/database_factory.dart';
import 'package:noteme/framework/sql/repository_base.dart';
import 'package:noteme/framework/sql/tables.dart';
import 'package:sqflite/sqflite.dart';

import 'models/notes_model.dart';

@lazySingleton
@injectable
class NoteRepository extends RepositoryBase<Note> {
  NoteRepository(NoteMeDatabaseFactory databaseFactory)
      : super(databaseFactory) {
    table = notesTable;
  }

  @override
  Note createFromMap(Map<String, dynamic> map) {
    return Note.fromJson(map);
  }
}
