import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/domain/notes/details/update/note_update_event.dart';
import 'package:noteme/domain/notes/details/update/note_update_state.dart';
import 'package:noteme/domain/notes/notes_repository.dart';

@injectable
class NoteUpdateBloc extends Bloc<NoteUpdateBaseEvent, NoteUpdateState> {
  final NoteRepository _noteRepository;

  NoteUpdateBloc(this._noteRepository);

  @override
  NoteUpdateState get initialState => NoteUpdateInitializedState();

  @override
  Stream<NoteUpdateState> mapEventToState(NoteUpdateBaseEvent event) async* {
    if (event is NoteUpdateInitializeEvent) {
      final note = await _noteRepository.fetchById(event.id);
      yield NoteUpdateLoadedState(note);
    }
  }
}
