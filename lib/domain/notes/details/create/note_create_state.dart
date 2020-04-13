abstract class NoteCreateState {}

class NoteCreateInitializedState extends NoteCreateState {}

class NoteCreateLoadingState extends NoteCreateState {}

class NoteCreatedState extends NoteCreateState {}

class NoteCreatedErrorState extends NoteCreateState {
  final Exception ex;

  NoteCreatedErrorState(this.ex);
}
