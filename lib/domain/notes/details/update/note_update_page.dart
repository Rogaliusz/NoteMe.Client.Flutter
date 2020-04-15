import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/domain/notes/attachments/models/attachment_model.dart';
import 'package:noteme/domain/notes/bloc/notes_event.dart';
import 'package:noteme/domain/notes/details/form/note_form.dart';
import 'package:noteme/domain/notes/details/update/note_update_bloc.dart';
import 'package:noteme/domain/notes/details/update/note_update_event.dart';
import 'package:noteme/domain/notes/details/update/note_update_state.dart';
import 'package:noteme/framework/i18n/local_factory.dart';
import 'package:noteme/framework/ioc/injection.iconfig.dart';
import 'package:noteme/framework/messages/message_bus.dart';
import 'package:noteme/framework/navigation/navigrator.dart';
import 'package:noteme/theme/backgrounds/logged_background.dart';
import 'package:noteme/theme/colors.dart';
import 'package:noteme/theme/widgets/loading_indicator.dart';
import 'package:noteme/theme/widgets/text_button.dart';

import '../../notes_message.dart';

@injectable
class NoteUpdatePage extends StatefulWidget {
  NoteUpdatePage() : super();

  @override
  NoteUpdatePageState createState() => getIt<NoteUpdatePageState>();
}

@injectable
class NoteUpdatePageState extends State<NoteUpdatePage> {
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController tagsController = new TextEditingController();
  final TextEditingController contentController = new TextEditingController();
  final List<Attachment> attachments = new List<Attachment>();
  final MessageBus _bus;

  NoteUpdatePageState(this._bus);

  @override
  Widget build(BuildContext context) {
    final locale = NoteMeLocaleFactory.of(context);
    final String id = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.global.update),
        backgroundColor: accentNoteMeColor,
      ),
      body: LoggedBackgroundBox(
        child: BlocProvider<NoteUpdateBloc>(
          create: (BuildContext context) => getIt<NoteUpdateBloc>(),
          child: BlocBuilder<NoteUpdateBloc, NoteUpdateState>(
            builder: (context, state) {
              if (state is NoteUpdateInitializedState) {
                BlocProvider.of<NoteUpdateBloc>(context)
                    .add(NoteUpdateInitializeEvent(id));
                return LoadingIndicator();
              }

              if (state is NoteUpdateLoadedState) {
                titleController.text = state.item.name;
                tagsController.text = state.item.tags;
                contentController.text = state.item.content;
                attachments.clear();
                attachments.addAll(state.attachments);

                GlobalKey<FormState> key = new GlobalKey<FormState>();

                return Column(children: <Widget>[
                  NoteForm(
                    key: key,
                    titleController: titleController,
                    tagsController: tagsController,
                    contentController: contentController,
                    attachments: attachments,
                  ),
                  TextNoteMeButton(
                    text: locale.global.update,
                    onPressed: () {
                      if (!key.currentState.validate()) {
                        return;
                      }

                      final event = NoteUpdateEvent(
                          id,
                          titleController.text,
                          tagsController.text,
                          contentController.text,
                          this.attachments);

                      BlocProvider.of<NoteUpdateBloc>(context).add(event);
                    },
                  )
                ]);
              }

              if (state is NoteUpdateLoadingState) {
                return LoadingIndicator();
              }

              if (state is NoteUpdatedState) {
                _bus.publish<NotesRetriveredMessage>(NotesRetriveredMessage());

                SchedulerBinding.instance.addPostFrameCallback((_) {
                  NoteMeNavigator.popUntil(context, (route) => route.isFirst);
                });
                return LoadingIndicator();
              }

              return LoadingIndicator();
            },
          ),
        ),
      ),
    );
  }
}
