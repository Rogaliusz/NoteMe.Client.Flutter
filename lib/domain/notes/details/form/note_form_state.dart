import 'package:noteme/domain/notes/attachments/models/attachment_model.dart';

abstract class NoteFormState {}

class NoteFormInitializedState extends NoteFormState {}

class NoteFormTakePictureState extends NoteFormState {}

class NoteFormNewAttachmentState extends NoteFormState {
  final Attachment attachment;
  final List<Attachment> attachments;

  NoteFormNewAttachmentState(this.attachment, this.attachments);
}
