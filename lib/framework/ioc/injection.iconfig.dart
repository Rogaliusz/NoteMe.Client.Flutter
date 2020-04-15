// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:noteme/framework/synchronizators/synchronization_repository.dart';
import 'package:noteme/framework/sql/database_factory.dart';
import 'package:noteme/framework/synchronizators/synchronization.dart';
import 'package:noteme/domain/notes/notes_synchronizator.dart';
import 'package:noteme/framework/messages/message_bus.dart';
import 'package:noteme/framework/hardware/camera/camera_service.dart';
import 'package:noteme/framework/hardware/camera/camera_screen.dart';
import 'package:noteme/framework/hardware/location/location_service.dart';
import 'package:noteme/framework/web/api/api_service.dart';
import 'package:noteme/framework/web/api/api_settings.dart';
import 'package:noteme/framework/workers/synchronization_worker.dart';
import 'package:noteme/framework/bloc/bloc_delegate.dart';
import 'package:noteme/theme/services/loader_service.dart';
import 'package:noteme/theme/services/toast_service.dart';
import 'package:noteme/theme/widgets/loading_indicator.dart';
import 'package:noteme/theme/widgets/splash_screen.dart';
import 'package:noteme/domain/auth/messages/logged_message.dart';
import 'package:noteme/domain/auth/signup/signup_view.dart';
import 'package:noteme/domain/auth/signup/signup_bloc.dart';
import 'package:noteme/domain/auth/authentication/authentication_bloc.dart';
import 'package:noteme/domain/notes/notes_repository.dart';
import 'package:noteme/domain/auth/login/login_bloc.dart';
import 'package:noteme/domain/auth/login/login_view.dart';
import 'package:noteme/domain/notes/notes_drawer.dart';
import 'package:noteme/domain/notes/details/form/note_form_bloc.dart';
import 'package:noteme/domain/notes/details/create/note_create_page.dart';
import 'package:noteme/domain/notes/details/create/note_create_bloc.dart';
import 'package:noteme/domain/notes/notes_view.dart';
import 'package:noteme/domain/notes/bloc/notes_bloc.dart';
import 'package:noteme/domain/notes/details/update/note_update.dart';
import 'package:noteme/domain/notes/details/update/note_update_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void $initGetIt({String environment}) {
  getIt
    ..registerFactory<SynchronizationRepository>(
        () => SynchronizationRepository(getIt<NoteMeDatabaseFactory>()))
    ..registerFactory<MainSynchronizator>(() => MainSynchronizator(
        getIt<SynchronizationRepository>(), getIt<NotesSynchronizator>()))
    ..registerLazySingleton<MessageBus>(() => MessageBus())
    ..registerLazySingleton<CameraService>(() => CameraService())
    ..registerFactory<CameraScreen>(() => CameraScreen())
    ..registerLazySingleton<LocationService>(() => LocationService())
    ..registerLazySingleton<ApiService>(() => ApiService(getIt<ApiSettings>()))
    ..registerLazySingleton<ApiSettings>(() => ApiSettings())
    ..registerLazySingleton<SynchronizationWorker>(
        () => SynchronizationWorker())
    ..registerFactory<NoteMeBlocDelegate>(() => NoteMeBlocDelegate())
    ..registerFactory<NoteMeDatabaseFactory>(() => NoteMeDatabaseFactory())
    ..registerFactory<LoaderService>(() => LoaderService())
    ..registerFactory<ToastService>(() => ToastService())
    ..registerFactory<LoadingIndicator>(() => LoadingIndicator())
    ..registerFactory<SplashPage>(() => SplashPage())
    ..registerLazySingleton<LoggedMessageHandler>(
        () => LoggedMessageHandler(getIt<ApiSettings>(), getIt<ApiService>()))
    ..registerFactory<SignupPage>(() => SignupPage())
    ..registerFactory<SignupPageState>(
        () => SignupPageState(getIt<ToastService>()))
    ..registerFactory<SignupBloc>(() => SignupBloc(getIt<ApiService>()))
    ..registerFactory<AuthenticationBloc>(() => AuthenticationBloc(
          getIt<ApiService>(),
          getIt<ApiSettings>(),
          getIt<NoteRepository>(),
          getIt<SynchronizationRepository>(),
        ))
    ..registerFactory<LoginBloc>(
        () => LoginBloc(getIt<ApiService>(), getIt<AuthenticationBloc>()))
    ..registerFactory<LoginPage>(() => LoginPage())
    ..registerLazySingleton<NoteRepository>(
        () => NoteRepository(getIt<NoteMeDatabaseFactory>()))
    ..registerFactory<NotesDrawer>(() => NotesDrawer(getIt<ApiSettings>()))
    ..registerFactory<NoteFormBloc>(() => NoteFormBloc())
    ..registerFactory<NoteCreatePage>(() => NoteCreatePage())
    ..registerFactory<NoteCreatePageState>(
        () => NoteCreatePageState(getIt<MessageBus>()))
    ..registerFactory<NoteCreateBloc>(
        () => NoteCreateBloc(getIt<NoteRepository>(), getIt<LocationService>()))
    ..registerFactory<NotesPage>(() => NotesPage())
    ..registerFactory<NotesPageState>(() => NotesPageState(getIt<MessageBus>()))
    ..registerLazySingleton<NotesSynchronizator>(() => NotesSynchronizator(
          getIt<MessageBus>(),
          getIt<ApiService>(),
          getIt<NoteRepository>(),
        ))
    ..registerFactory<NotesBloc>(() => NotesBloc(getIt<NoteRepository>()))
    ..registerFactory<NoteUpdatePage>(() => NoteUpdatePage())
    ..registerFactory<NoteUpdatePageState>(() => NoteUpdatePageState())
    ..registerFactory<NoteUpdateBloc>(
        () => NoteUpdateBloc(getIt<NoteRepository>()));
}
