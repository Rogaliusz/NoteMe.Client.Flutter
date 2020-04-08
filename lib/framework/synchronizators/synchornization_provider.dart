import 'package:noteme/framework/sql/id_provider.dart';
import 'package:noteme/framework/synchronizators/models/synchronization_model.dart';

abstract class SynchonizationProvider implements IdProvider {
  DateTime lastSynchronization;
  SynchronizationStatusEnum statusSynchronization;

  Map<String, dynamic> toJson();
}

enum SynchronizationStatusEnum {
  Ok,
  NeedInsert,
  NeedUpdate,
  NeedDelete,
  NeedUpload,
}

abstract class SynchronizationHandlerBase<
    TModel extends SynchonizationProvider> {
  Future<void> syncIt(Synchronization synchronization);
}
