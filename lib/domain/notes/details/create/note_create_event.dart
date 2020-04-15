import 'package:noteme/domain/notes/attachments/models/attachment_model.dart';

abstract class NoteCreateBaseEvent {}

class NoteCreateEvent extends NoteCreateBaseEvent {
  final String titile;
  final String tags;
  final String content;
  final List<Attachment> attachments;

  NoteCreateEvent(this.titile, this.tags, this.content, this.attachments);
}
