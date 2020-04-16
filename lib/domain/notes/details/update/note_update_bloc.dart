import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/domain/notes/attachments/attachment_repository.dart';
import 'package:noteme/domain/notes/details/update/note_update_event.dart';
import 'package:noteme/domain/notes/details/update/note_update_state.dart';
import 'package:noteme/domain/notes/notes_repository.dart';
import 'package:noteme/framework/synchronizators/synchornization_provider.dart';
import 'package:uuid/uuid.dart';

@injectable
class NoteUpdateBloc extends Bloc<NoteUpdateBaseEvent, NoteUpdateState> {
  final NoteRepository _noteRepository;
  final AttachmentRepository _attachmentRepository;

  NoteUpdateBloc(this._noteRepository, this._attachmentRepository);

  @override
  NoteUpdateState get initialState => NoteUpdateInitializedState();

  @override
  Stream<NoteUpdateState> mapEventToState(NoteUpdateBaseEvent event) async* {
    if (event is NoteUpdateInitializeEvent) {
      yield NoteUpdateLoadingState();

      final note = await _noteRepository.fetchById(event.id);
      final attachments = await _attachmentRepository.fetch();

      yield NoteUpdateLoadedState(
          note, attachments.where((x) => x.noteId == note.id).toList());
    }

    if (event is NoteUpdateEvent) {
      try {
        yield NoteUpdateLoadingState();

        final note = await _noteRepository.fetchById(event.id);
        note.name = event.titile;
        note.tags = event.tags;
        note.content = event.content;
        note.statusSynchronization = SynchronizationStatusWrapper.needUpdate;

        await _noteRepository.update(note);

        for (final attachment in event.attachments) {
          attachment.noteId = note.id;
          await _attachmentRepository.insert(attachment);
        }
        yield NoteUpdatedState();
      } catch (ex) {
        yield NoteUpdatedErrorState(ex);
      }
    }
  }
}
