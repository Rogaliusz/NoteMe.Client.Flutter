abstract class NoteCreateBaseEvent {}

class NoteCreateEvent extends NoteCreateBaseEvent {
  final String titile;
  final String tags;
  final String content;

  NoteCreateEvent(this.titile, this.tags, this.content);
}
