import 'package:noteme/domain/notes/attachments/models/attachment_model.dart';

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
  final List<Attachment> attachments;

  NoteUpdateEvent(
      this.id, this.titile, this.tags, this.content, this.attachments);
}
