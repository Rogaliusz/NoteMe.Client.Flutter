import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/domain/auth/login/login_bloc.dart';
import 'package:noteme/domain/auth/login/login_view.dart';
import 'package:noteme/domain/notes/notes_view.dart';
import 'package:noteme/framework/ioc/injection.iconfig.dart';
import 'package:noteme/framework/messages/message_bus.dart';
import 'package:noteme/framework/web/api/api_settings.dart';
import 'package:noteme/generated/locale_base.dart';
import 'package:noteme/locales/locale_delegate.dart';
import 'package:noteme/theme/colors.dart';
import 'package:noteme/theme/services/loader_service.dart';
import 'package:noteme/theme/widgets/loading_indicator.dart';
import 'package:noteme/theme/widgets/splash_screen.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'domain/auth/authentication/authentication_bloc.dart';
import 'domain/auth/authentication/authentication_event.dart';
import 'domain/auth/authentication/authentication_state.dart';
import 'domain/auth/messages/logged_message.dart';
import 'framework/ioc/injection.dart';
import 'main_init.dart';

void main() async {
  await initialize();
  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return getIt<AuthenticationBloc>()..add(AppStarted());
    },
    child: NoteMeApp(),
  ));
}

class NoteMeApp extends StatelessWidget {
  NoteMeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteMe',
      localizationsDelegates: [
        const LocDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('pl'),
      ],
      theme: ThemeData(
          primaryColor: primaryNoteMeColor,
          accentColor: accentNoteMeColor,
          errorColor: errorNoteMeColor),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return NotesPage();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage();
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
}
