import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/domain/notes/details/create/note_create_event.dart';
import 'package:noteme/domain/notes/details/create/note_create_state.dart';
import 'package:noteme/domain/notes/models/notes_model.dart';
import 'package:noteme/domain/notes/notes_repository.dart';
import 'package:noteme/framework/synchronizators/synchornization_provider.dart';
import 'package:uuid/uuid.dart';

@injectable
class NoteCreateBloc extends Bloc<NoteCreateBaseEvent, NoteCreateState> {
  final NoteRepository _repository;

  NoteCreateBloc(this._repository);

  @override
  NoteCreateState get initialState => NoteCreateInitializedState();

  @override
  Stream<NoteCreateState> mapEventToState(NoteCreateBaseEvent event) async* {
    if (event is NoteCreateEvent) {
      yield NoteCreateLoadingState();

      try {
        final note = new Note();
        note.id = Uuid().v1();
        note.name = event.titile;
        note.tags = event.tags;
        note.content = event.content;
        note.createdAt = DateTime.now().toUtc();
        note.statusSynchronization = SynchronizationStatusWrapper.needInsert;

        await _repository.insert(note);

        yield NoteCreatedState();
      } catch (ex) {
        yield NoteCreatedErrorState(ex);
      }
    }
  }
}
