// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:noteme/framework/synchronizators/synchronization_repository.dart';
import 'package:noteme/framework/sql/database_factory.dart';
import 'package:noteme/framework/synchronizators/synchronization.dart';
import 'package:noteme/domain/notes/notes_synchronizator.dart';
import 'package:noteme/framework/web/api/api_service.dart';
import 'package:noteme/framework/web/api/api_settings.dart';
import 'package:noteme/framework/workers/synchronization_worker.dart';
import 'package:noteme/theme/services/loader_service.dart';
import 'package:noteme/theme/services/toast_service.dart';
import 'package:noteme/domain/auth/signup/signup_view.dart';
import 'package:noteme/domain/auth/signup/signup_bloc.dart';
import 'package:noteme/domain/auth/login/login_bloc.dart';
import 'package:noteme/framework/messages/message_bus.dart';
import 'package:noteme/domain/auth/login/login_view.dart';
import 'package:noteme/domain/notes/notes_repository.dart';
import 'package:noteme/domain/notes/notes_view.dart';
import 'package:noteme/domain/auth/messages/logged_message.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void $initGetIt({String environment}) {
  getIt
    ..registerFactory<SynchronizationRepository>(
        () => SynchronizationRepository(getIt<NoteMeDatabaseFactory>()))
    ..registerFactory<MainSynchronizator>(() => MainSynchronizator(
        getIt<SynchronizationRepository>(), getIt<NotesSynchronizator>()))
    ..registerLazySingleton<ApiService>(() => ApiService(getIt<ApiSettings>()))
    ..registerLazySingleton<ApiSettings>(() => ApiSettings())
    ..registerLazySingleton<SynchronizationWorker>(
        () => SynchronizationWorker())
    ..registerFactory<NoteMeDatabaseFactory>(() => NoteMeDatabaseFactory())
    ..registerFactory<LoaderService>(() => LoaderService())
    ..registerFactory<ToastService>(() => ToastService())
    ..registerFactory<SignupPage>(() => SignupPage())
    ..registerFactory<SignupPageState>(() => SignupPageState())
    ..registerFactory<SignupBloc>(() => SignupBloc(getIt<ApiService>()))
    ..registerFactory<LoginBloc>(() => LoginBloc(
          getIt<LoaderService>(),
          getIt<ApiSettings>(),
          getIt<ApiService>(),
          getIt<MessageBus>(),
        ))
    ..registerFactory<LoginPage>(() => LoginPage())
    ..registerFactory<LoginPageState>(
        () => LoginPageState(getIt<ToastService>()))
    ..registerLazySingleton<NoteRepository>(
        () => NoteRepository(getIt<NoteMeDatabaseFactory>()))
    ..registerFactory<NotesPage>(() => NotesPage())
    ..registerFactory<NotesPageState>(() => NotesPageState())
    ..registerLazySingleton<NotesSynchronizator>(
        () => NotesSynchronizator(getIt<ApiService>(), getIt<NoteRepository>()))
    ..registerLazySingleton<LoggedMessageHandler>(
        () => LoggedMessageHandler(getIt<ApiSettings>(), getIt<ApiService>()))
    ..registerLazySingleton<MessageBus>(() => MessageBus());
}
