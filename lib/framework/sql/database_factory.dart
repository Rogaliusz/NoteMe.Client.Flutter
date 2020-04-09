import 'package:injectable/injectable.dart';
import 'package:noteme/framework/sql/tables.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

@injectable
class NoteMeDatabaseFactory {
  Future<Database> create() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'notes7.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE $notesTable (id TEXT PRIMARY KEY, name TEXT, content TEXT, tags TEXT, createdAt DATETIME, modifiedAt DATETIME, latitude REAL, longitude REAL, lastSynchronization DATETIME, statusSynchronization INTEGER, status INTEGER);");
        await db.execute(
            "CREATE TABLE $synchroTable (id TEXT PRIMARY KEY, lastSynchronization DATETIME, statusSynchronization INTEGER); ");
      },
      version: 5,
    );

    return database;
  }
}
