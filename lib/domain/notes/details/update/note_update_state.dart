import 'package:noteme/domain/notes/attachments/models/attachment_model.dart';
import 'package:noteme/domain/notes/models/notes_model.dart';

abstract class NoteUpdateState {}

class NoteUpdateInitializedState extends NoteUpdateState {}

class NoteUpdateLoadedState extends NoteUpdateState {
  final Note item;
  final List<Attachment> attachments;

  NoteUpdateLoadedState(this.item, this.attachments);
}

class NoteUpdateLoadingState extends NoteUpdateState {}

class NoteUpdatedState extends NoteUpdateState {}

class NoteUpdatedErrorState extends NoteUpdateState {
  final Exception ex;

  NoteUpdatedErrorState(this.ex);
}
