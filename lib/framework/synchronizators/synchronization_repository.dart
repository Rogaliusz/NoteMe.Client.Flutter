import 'package:injectable/injectable.dart';
import 'package:noteme/framework/sql/database_factory.dart';
import 'package:noteme/framework/sql/repository_base.dart';
import 'package:noteme/framework/sql/tables.dart';
import 'package:noteme/framework/synchronizators/models/synchronization_model.dart';
import 'package:sqflite/sqflite.dart';

@injectable
class SynchronizationRepository extends RepositoryBase<Synchronization> {
  SynchronizationRepository(NoteMeDatabaseFactory databaseFactory)
      : super(databaseFactory) {
    table = synchroTable;
  }

  @override
  Synchronization createFromMap(Map<String, dynamic> map) {
    return Synchronization.fromJson(map);
  }
}
