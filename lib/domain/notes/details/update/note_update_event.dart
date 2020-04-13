abstract class NoteUpdateBaseEvent {}

class NoteUpdateInitializeEvent extends NoteUpdateBaseEvent {
  final String id;

  NoteUpdateInitializeEvent(this.id);
}

class NoteUpdateEvent extends NoteUpdateBaseEvent {
  final String id;
  final String titile;
  final String tags;
  final String content;

  NoteUpdateEvent(this.id, this.titile, this.tags, this.content);
}
