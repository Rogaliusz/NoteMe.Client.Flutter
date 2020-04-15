import 'package:noteme/domain/notes/attachments/models/attachment_model.dart';

abstract class NoteFormEvent {}

class NoteFormInitializedEvent extends NoteFormEvent {}

class NoteFormTakePictureEvent extends NoteFormEvent {}

class NoteFormAddedAttachmentEvent extends NoteFormEvent {
  final Attachment attachment;
  final List<Attachment> attachments;

  NoteFormAddedAttachmentEvent(this.attachment, this.attachments);
}
