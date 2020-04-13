abstract class NoteFormEvent {}

class NoteFormInitializedEvent extends NoteFormEvent {}

class NoteFormTakePictureEvent extends NoteFormEvent {}

class NoteFormAddedAttachmentEvent extends NoteFormEvent {
  final String attachment;
  final List<String> attachments;

  NoteFormAddedAttachmentEvent(this.attachment, this.attachments);
}
