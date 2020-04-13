abstract class NoteFormState {}

class NoteFormInitializedState extends NoteFormState {}

class NoteFormTakePictureState extends NoteFormState {}

class NoteFormNewAttachmentState extends NoteFormState {
  final String attachment;
  final List<String> attachments;

  NoteFormNewAttachmentState(this.attachment, this.attachments);
}
