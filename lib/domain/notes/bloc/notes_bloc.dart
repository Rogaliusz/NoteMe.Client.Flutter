import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/domain/common/status_enum.dart';
import 'package:noteme/domain/notes/bloc/notes_event.dart';
import 'package:noteme/domain/notes/bloc/notes_state.dart';
import 'package:noteme/domain/notes/notes_repository.dart';

@injectable
class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NoteRepository _repository;

  NotesBloc(this._repository);

  @override
  // TODO: implement initialState
  NotesState get initialState => NotesLoadingState();

  @override
  Stream<NotesState> mapEventToState(NotesEvent event) async* {
    if (event is NotesInitializeEvent || event is NotesFetchEvent) {
      yield NotesLoadingState();
      final notes = await _repository.fetch()
        ..sort((x, y) =>
            y.createdAt.microsecondsSinceEpoch -
            x.createdAt.microsecondsSinceEpoch);

      final filteredNotes =
          notes.where((x) => x.status == StatusWrapper.normal).toList();

      yield NotesFetchedState(filteredNotes);
    }
  }
}
