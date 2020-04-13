import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/domain/notes/bloc/notes_event.dart';
import 'package:noteme/domain/notes/details/form/note_form.dart';
import 'package:noteme/domain/notes/details/update/note_update_bloc.dart';
import 'package:noteme/domain/notes/details/update/note_update_event.dart';
import 'package:noteme/domain/notes/details/update/note_update_state.dart';
import 'package:noteme/framework/i18n/local_factory.dart';
import 'package:noteme/framework/ioc/injection.iconfig.dart';
import 'package:noteme/theme/backgrounds/logged_background.dart';
import 'package:noteme/theme/colors.dart';
import 'package:noteme/theme/widgets/loading_indicator.dart';
import 'package:noteme/theme/widgets/text_button.dart';

@injectable
class NoteUpdatePage extends StatefulWidget {
  NoteUpdatePage() : super();

  @override
  NoteUpdatePageState createState() => NoteUpdatePageState();
}

@injectable
class NoteUpdatePageState extends State<NoteUpdatePage> {
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController tagsController = new TextEditingController();
  final TextEditingController contentController = new TextEditingController();
  final GlobalKey<FormState> key = new GlobalKey<FormState>();
  final List<String> attachments = new List<String>();

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
              }

              if (state is NoteUpdateLoadingState) {
                return LoadingIndicator();
              }

              if (state is NoteUpdatedState) {}

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
                    if (!this.key.currentState.validate()) {
                      return;
                    }

                    final event = NoteUpdateEvent(id, titleController.text,
                        tagsController.text, contentController.text);

                    BlocProvider.of<NoteUpdateBloc>(context).add(event);
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
