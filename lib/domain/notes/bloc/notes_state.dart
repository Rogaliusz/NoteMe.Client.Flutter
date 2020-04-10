import 'package:equatable/equatable.dart';
import 'package:noteme/domain/notes/models/notes_model.dart';

abstract class NotesState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotesLoadingState extends NotesState {}

class NotesFetchedState extends NotesState {
  final List<Note> items;

  NotesFetchedState(this.items);
}
