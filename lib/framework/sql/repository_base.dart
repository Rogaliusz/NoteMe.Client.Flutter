import 'package:noteme/framework/synchronizators/synchornization_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'database_factory.dart';

abstract class RepositoryBase<TModel extends SynchonizationProvider> {
  final NoteMeDatabaseFactory _databaseFactory;
  String table;

  RepositoryBase(this._databaseFactory);

  Future<void> insert(TModel item) async {
    final db = await _databaseFactory.create();
    db.insert(table, item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertMany(List<TModel> items) async {
    final db = await _databaseFactory.create();

    for (var item in items) {
      db.insert(table, item.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<void> update(TModel item) async {
    final db = await _databaseFactory.create();

    await db.update(
      table,
      item.toJson(),
      where: "id = ?",
      whereArgs: [item.id],
    );
  }

  Future<TModel> fetchById(String id) async {
    final Database db = await _databaseFactory.create();
    final List<Map<String, dynamic>> maps =
        await db.query(table, where: "id = ?", whereArgs: [id]);

    if (maps.length == 0) {
      return null;
    }

    final map = maps[0];
    return createFromMap(map);
  }

  Future<List<TModel>> fetch() async {
    final Database db = await _databaseFactory.create();
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return createFromMap(maps[i]);
    });
  }

  Future clear() async {
    final Database db = await _databaseFactory.create();
    await db.delete(table);
  }

  TModel createFromMap(Map<String, dynamic> map);
}
