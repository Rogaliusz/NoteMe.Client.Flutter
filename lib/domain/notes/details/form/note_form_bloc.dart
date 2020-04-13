import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/domain/notes/details/form/note_form_event.dart';
import 'package:noteme/domain/notes/details/form/note_form_state.dart';

@injectable
class NoteFormBloc extends Bloc<NoteFormEvent, NoteFormState> {
  @override
  NoteFormState get initialState => NoteFormInitializedState();

  @override
  Stream<NoteFormState> mapEventToState(NoteFormEvent event) async* {
    if (event is NoteFormInitializedEvent) {
      yield NoteFormInitializedState();
    }

    if (event is NoteFormTakePictureEvent) {
      yield NoteFormTakePictureState();
    }

    if (event is NoteFormAddedAttachmentEvent) {
      yield NoteFormNewAttachmentState(event.attachment, event.attachments);
    }
  }
}
