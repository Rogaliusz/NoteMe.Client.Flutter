import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:noteme/domain/auth/authentication/authentication_bloc.dart';
import 'package:noteme/domain/notes/bloc/notes_event.dart';
import 'package:noteme/domain/notes/notes_drawer.dart';
import 'package:noteme/domain/notes/notes_message.dart';
import 'package:noteme/framework/i18n/local_factory.dart';
import 'package:noteme/framework/ioc/injection.iconfig.dart';
import 'package:noteme/framework/messages/message_bus.dart';
import 'package:noteme/framework/navigation/navigrator.dart';

import 'package:noteme/theme/backgrounds/logged_background.dart';
import 'package:noteme/theme/colors.dart';
import 'package:noteme/theme/widgets/loading_indicator.dart';
import 'package:noteme/theme/widgets/text_primary.dart';
import 'package:noteme/theme/widgets/title_text.dart';

import 'bloc/notes_bloc.dart';
import 'bloc/notes_state.dart';
import 'details/update/note_update_page.dart';
import 'models/notes_model.dart';

@injectable
class NotesPage extends StatefulWidget {
  NotesPage() : super();

  @override
  NotesPageState createState() => getIt<NotesPageState>();
}

@injectable
class NotesPageState extends State<NotesPage> {
  final MessageBus _bus;

  NotesPageState(this._bus);

  @override
  Widget build(BuildContext context) {
    final locale = NoteMeLocaleFactory.of(context);

    return BlocProvider(
        create: (context) {
          return getIt<NotesBloc>()..add(NotesInitializeEvent());
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(locale.notes.title),
              backgroundColor: accentNoteMeColor,
            ),
            drawer: getIt<NotesDrawer>(),
            body: LoggedBackgroundBox(child:
                BlocBuilder<NotesBloc, NotesState>(builder: (context, state) {
              _bus.subscribe<NotesRetriveredMessage>((x) {
                BlocProvider.of<NotesBloc>(context).add(NotesFetchEvent());
              });

              if (state is NotesFetchedState) {
                final items = state.items;
                return ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return NoteItem(items[index]);
                    });
              }

              return LoadingIndicator();
            }))));
  }
}

class NoteItem extends StatelessWidget {
  final Note _item;

  NoteItem(this._item) : super();

  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");

    return GestureDetector(
        onTap: () {
          NoteMeNavigator.push<NoteUpdatePage>(context,
              settings: RouteSettings(arguments: _item.id));
        },
        child: Container(
            decoration: BoxDecoration(
                color: backgroundNoteMeColor,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0),
                )),
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 20,
                  height: 50,
                ),
                Image.asset(
                  'assets/note_icon.png',
                  height: 24,
                  width: 24,
                ),
                SizedBox(
                  width: 20,
                  height: 50,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      PrimaryText(this._item.name, 22,
                          textAlign: TextAlign.start),
                      SizedBox(
                        height: 20,
                      ),
                      PrimaryText(format.format(_item.createdAt), 12,
                          textAlign: TextAlign.end),
                      SizedBox(
                        height: 10,
                      ),
                    ])
              ],
            )));
  }
}
