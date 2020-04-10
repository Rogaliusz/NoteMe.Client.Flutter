// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:noteme/framework/synchronizators/synchronization_repository.dart';
import 'package:noteme/framework/sql/database_factory.dart';
import 'package:noteme/framework/synchronizators/synchronization.dart';
import 'package:noteme/domain/notes/notes_synchronizator.dart';
import 'package:noteme/framework/messages/message_bus.dart';
import 'package:noteme/framework/web/api/api_service.dart';
import 'package:noteme/framework/web/api/api_settings.dart';
import 'package:noteme/framework/workers/synchronization_worker.dart';
import 'package:noteme/theme/services/loader_service.dart';
import 'package:noteme/theme/services/toast_service.dart';
import 'package:noteme/domain/auth/messages/logged_message.dart';
import 'package:noteme/domain/auth/signup/signup_view.dart';
import 'package:noteme/domain/auth/signup/signup_bloc.dart';
import 'package:noteme/domain/auth/login/login_bloc.dart';
import 'package:noteme/domain/auth/authentication/authentication_bloc.dart';
import 'package:noteme/domain/auth/login/login_view.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:noteme/domain/notes/notes_repository.dart';
import 'package:noteme/domain/notes/notes_view.dart';
import 'package:noteme/framework/bloc/bloc_delegate.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void $initGetIt({String environment}) {
  getIt
    ..registerFactory<SynchronizationRepository>(
        () => SynchronizationRepository(getIt<NoteMeDatabaseFactory>()))
    ..registerFactory<MainSynchronizator>(() => MainSynchronizator(
        getIt<SynchronizationRepository>(), getIt<NotesSynchronizator>()))
    ..registerLazySingleton<MessageBus>(() => MessageBus())
    ..registerLazySingleton<ApiService>(() => ApiService(getIt<ApiSettings>()))
    ..registerLazySingleton<ApiSettings>(() => ApiSettings())
    ..registerLazySingleton<SynchronizationWorker>(
        () => SynchronizationWorker())
    ..registerFactory<NoteMeDatabaseFactory>(() => NoteMeDatabaseFactory())
    ..registerFactory<LoaderService>(() => LoaderService())
    ..registerFactory<ToastService>(() => ToastService())
    ..registerLazySingleton<LoggedMessageHandler>(
        () => LoggedMessageHandler(getIt<ApiSettings>(), getIt<ApiService>()))
    ..registerFactory<SignupPage>(() => SignupPage())
    ..registerFactory<SignupPageState>(() => SignupPageState())
    ..registerFactory<SignupBloc>(() => SignupBloc(getIt<ApiService>()))
    ..registerFactory<LoginBloc>(
        () => LoginBloc(getIt<ApiService>(), getIt<AuthenticationBloc>()))
    ..registerFactory<LoginPage>(() => LoginPage(key: getIt<Key>()))
    ..registerLazySingleton<NoteRepository>(
        () => NoteRepository(getIt<NoteMeDatabaseFactory>()))
    ..registerFactory<NotesPage>(() => NotesPage())
    ..registerFactory<NotesPageState>(() => NotesPageState())
    ..registerLazySingleton<NotesSynchronizator>(
        () => NotesSynchronizator(getIt<ApiService>(), getIt<NoteRepository>()))
    ..registerFactory<NoteMeBlocDelegate>(() => NoteMeBlocDelegate())
    ..registerFactory<AuthenticationBloc>(
        () => AuthenticationBloc(getIt<ApiSettings>()));
}
