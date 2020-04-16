import 'package:injectable/injectable.dart';
import 'package:noteme/domain/notes/attachments/attachment_synchronizator.dart';
import 'package:noteme/domain/notes/notes_synchronizator.dart';
import 'package:noteme/framework/synchronizators/models/synchronization_model.dart';
import 'package:noteme/framework/synchronizators/synchornization_provider.dart';
import 'package:noteme/framework/synchronizators/synchronization_repository.dart';

abstract class SynchronizatorBase<TModel> {
  Future synchronize();
}

@injectable
class MainSynchronizator {
  final SynchronizationRepository _repository;
  final NotesSynchronizator _notesSynchronizator;
  final AttachmentsSynchronizator _attachmentsSynchronizator;

  MainSynchronizator(this._repository, this._notesSynchronizator,
      this._attachmentsSynchronizator);

  Future<void> synchronize() async {
    var synchros = await _repository.fetch();
    if (synchros.length == 0) {
      var synchro = new Synchronization(
          id: 'main',
          lastSynchronization: DateTime.fromMillisecondsSinceEpoch(1).toUtc(),
          statusSynchronization: SynchronizationStatusWrapper.ok);

      await _repository.insert(synchro);
      synchros = await _repository.fetch();
    }

    var lastSync = synchros[0];

    await _notesSynchronizator.syncIt(lastSync);
    await _attachmentsSynchronizator.syncIt(lastSync);

    lastSync.lastSynchronization = DateTime.now().toUtc();
    await _repository.update(lastSync);
  }
}
