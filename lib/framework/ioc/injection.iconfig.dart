// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:noteme/framework/web/api/api_service.dart';
import 'package:noteme/framework/web/api/api_settings.dart';
import 'package:noteme/theme/services/loader_service.dart';
import 'package:noteme/domain/auth/signup/signup_view.dart';
import 'package:noteme/domain/auth/signup/signup_bloc.dart';
import 'package:noteme/domain/auth/login/login_bloc.dart';
import 'package:noteme/domain/auth/login/login_view.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void $initGetIt({String environment}) {
  getIt
    ..registerFactory<ApiService>(() => ApiService(getIt<ApiSettings>()))
    ..registerFactory<ApiSettings>(() => ApiSettings())
    ..registerFactory<LoaderService>(() => LoaderService())
    ..registerFactory<SignupPage>(() => SignupPage())
    ..registerFactory<SignupPageState>(() => SignupPageState())
    ..registerFactory<SignupBloc>(() => SignupBloc(getIt<ApiService>()))
    ..registerFactory<LoginBloc>(
        () => LoginBloc(getIt<LoaderService>(), getIt<ApiService>()))
    ..registerFactory<LoginPage>(() => LoginPage())
    ..registerFactory<LoginPageState>(() => LoginPageState());
}
