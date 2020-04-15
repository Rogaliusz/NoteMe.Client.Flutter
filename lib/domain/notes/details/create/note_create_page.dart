import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/domain/notes/bloc/notes_bloc.dart';
import 'package:noteme/domain/notes/bloc/notes_event.dart';
import 'package:noteme/domain/notes/details/create/note_create_bloc.dart';
import 'package:noteme/domain/notes/details/create/note_create_event.dart';
import 'package:noteme/domain/notes/details/form/note_form.dart';
import 'package:noteme/domain/notes/notes_message.dart';
import 'package:noteme/framework/i18n/local_factory.dart';
import 'package:noteme/framework/ioc/injection.iconfig.dart';
import 'package:noteme/framework/messages/message_bus.dart';
import 'package:noteme/framework/navigation/navigrator.dart';
import 'package:noteme/theme/backgrounds/logged_background.dart';
import 'package:noteme/theme/colors.dart';
import 'package:noteme/theme/widgets/loading_indicator.dart';
import 'package:noteme/theme/widgets/text_button.dart';

import '../../notes_view.dart';
import 'note_create_state.dart';

@injectable
class NoteCreatePage extends StatefulWidget {
  NoteCreatePage();

  @override
  NoteCreatePageState createState() => getIt<NoteCreatePageState>();
}

@injectable
class NoteCreatePageState extends State<NoteCreatePage> {
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController tagsController = new TextEditingController();
  final TextEditingController contentController = new TextEditingController();
  final GlobalKey<FormState> key = new GlobalKey<FormState>();
  final List<String> attachments = new List<String>();
  final MessageBus _bus;

  NoteCreatePageState(this._bus);

  @override
  Widget build(BuildContext parentContext) {
    final locale = NoteMeLocaleFactory.of(parentContext);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.global.add),
        backgroundColor: accentNoteMeColor,
      ),
      body: LoggedBackgroundBox(
        child: BlocProvider<NoteCreateBloc>(
          create: (BuildContext context) => getIt<NoteCreateBloc>(),
          child: BlocBuilder<NoteCreateBloc, NoteCreateState>(
            builder: (context, state) {
              if (state is NoteCreateLoadingState) {
                return LoadingIndicator();
              }

              if (state is NoteCreatedState) {
                _bus.publish<NotesRetriveredMessage>(NotesRetriveredMessage());
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  NoteMeNavigator.popUntil(context, (route) => route.isFirst);
                });
              }

              return Column(children: <Widget>[
                NoteForm(
                  key: key,
                  titleController: titleController,
                  tagsController: tagsController,
                  contentController: contentController,
                  attachments: attachments,
                ),
                TextNoteMeButton(
                  text: locale.global.create,
                  onPressed: () {
                    if (!this.key.currentState.validate()) {
                      return;
                    }

                    final event = NoteCreateEvent(titleController.text,
                        tagsController.text, contentController.text);

                    BlocProvider.of<NoteCreateBloc>(context).add(event);
                  },
                )
              ]);
            },
          ),
        ),
      ),
    );
  }
}
