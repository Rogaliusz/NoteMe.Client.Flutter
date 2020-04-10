import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:noteme/domain/auth/authentication/authentication_bloc.dart';
import 'package:noteme/domain/auth/authentication/authentication_event.dart';
import 'package:noteme/domain/auth/login/models/jwt_model.dart';
import 'package:noteme/domain/auth/login/states/login_state.dart';
import 'package:noteme/framework/web/api/api_endpoints.dart';
import 'package:noteme/framework/web/api/api_service.dart';

import 'events/login_event.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService _apiService;
  final AuthenticationBloc _authenticationBloc;

  LoginBloc(this._apiService, this._authenticationBloc);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final response = await _apiService.post(LoginEndpoint, event);
        final user = Jwt.fromJson(response.json);

        _authenticationBloc.add(LoggedIn(user));

        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
