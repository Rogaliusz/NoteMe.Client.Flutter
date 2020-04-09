import 'package:noteme/framework/sql/id_provider.dart';
import 'package:noteme/framework/synchronizators/models/synchronization_model.dart';

abstract class SynchonizationProvider implements IdProvider {
  DateTime lastSynchronization;
  int statusSynchronization;

  Map<String, dynamic> toJson();
}

enum SynchronizationStatusEnum {
  Ok,
  NeedInsert,
  NeedUpdate,
  NeedDelete,
  NeedUpload,
}

class SynchronizationStatusWrapper {
  static int ok = 0;
  static int needInsert = 1;
  static int needUpdate = 2;
  static int needDelete = 3;
  static int needUpload = 4;
}

abstract class SynchronizationHandlerBase<
    TModel extends SynchonizationProvider> {
  Future<void> syncIt(Synchronization synchronization);
}
