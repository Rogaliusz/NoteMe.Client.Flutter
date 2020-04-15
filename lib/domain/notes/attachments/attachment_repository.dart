import 'package:injectable/injectable.dart';
import 'package:noteme/domain/notes/attachments/models/attachment_model.dart';
import 'package:noteme/framework/sql/database_factory.dart';
import 'package:noteme/framework/sql/repository_base.dart';
import 'package:noteme/framework/sql/tables.dart';
import 'package:sqflite/sqlite_api.dart';

@injectable
@lazySingleton
class AttachmentRepository extends RepositoryBase<Attachment> {
  AttachmentRepository(NoteMeDatabaseFactory databaseFactory)
      : super(databaseFactory) {
    table = attachmentsTable;
  }

  @override
  Attachment createFromMap(Map<String, dynamic> map) {
    return Attachment.fromJson(map);
  }
}
