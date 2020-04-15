import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/domain/auth/authentication/authentication_bloc.dart';
import 'package:noteme/domain/auth/authentication/authentication_event.dart';
import 'package:noteme/domain/notes/details/create/note_create_page.dart';
import 'package:noteme/framework/i18n/local_factory.dart';
import 'package:noteme/framework/navigation/navigrator.dart';
import 'package:noteme/framework/web/api/api_settings.dart';
import 'package:noteme/theme/widgets/icon.dart';
import 'package:noteme/theme/widgets/text_primary.dart';

@injectable
class NotesDrawer extends StatelessWidget {
  final ApiSettings _apiSettings;

  BuildContext parnetContext;

  NotesDrawer(this._apiSettings);

  @override
  Widget build(BuildContext context) {
    final locale = NoteMeLocaleFactory.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          ListTile(
            title: PrimaryText(
                locale.global.welcome +
                    ' ' +
                    _apiSettings.loggedUser.user.email,
                25),
          ),
          ListTile(
              leading: PrimaryIcon(Icons.add),
              title: PrimaryText(locale.global.add, 12),
              onTap: () {
                NoteMeNavigator.pop(context);
                NoteMeNavigator.push<NoteCreatePage>(context);
              }),
          ListTile(
              leading: PrimaryIcon(Icons.exit_to_app),
              title: PrimaryText(locale.global.logout, 12),
              onTap: () {
                final bloc = BlocProvider.of<AuthenticationBloc>(context);
                bloc.add(LoggedOut());
              }),
        ],
      ),
    );
  }
}
