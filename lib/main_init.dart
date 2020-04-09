import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/framework/messages/message_bus.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'framework/ioc/injection.dart';
import 'framework/ioc/injection.iconfig.dart';
import 'framework/sql/database_factory.dart';

Future initialize() async {
  configureInjection(Environment.production);
  WidgetsFlutterBinding.ensureInitialized();
  await getIt<NoteMeDatabaseFactory>().create();
  getIt<MessageBus>().registerHandlers();
}
