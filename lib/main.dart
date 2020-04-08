import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/domain/auth/login/login_view.dart';
import 'package:noteme/framework/ioc/injection.iconfig.dart';
import 'package:noteme/framework/web/api/api_settings.dart';
import 'package:noteme/generated/locale_base.dart';
import 'package:noteme/locales/locale_delegate.dart';
import 'package:noteme/theme/colors.dart';
import 'package:noteme/theme/services/loader_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'framework/ioc/injection.dart';
import 'main_init.dart';

void main() async {
  await initialize();
  runApp(NoteMeApp());
}

class NoteMeApp extends StatelessWidget {
  ApiSettings _apiSettings;

  NoteMeApp() {}

  void onData(bool event) {}

  @override
  Widget build(BuildContext context) {
    _apiSettings = getIt<ApiSettings>();

    return FlutterEasyLoading(
        child: MaterialApp(
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
            home: FutureBuilder(
              future: isLoggedIn(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data ? Container() : LoginPage();
                }
                return Container(); // noop, this builder is called again when the future completes
              },
            )));
  }

  Future<bool> isLoggedIn() async {
    return false;
  }
}
