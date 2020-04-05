import 'package:noteme/domain/auth/login/models/jwt_model.dart';

abstract class LoggedState {}

class LoginOkState extends LoggedState {
  Jwt token;

  LoginOkState(this.token);
}

class LoginErrorState extends LoggedState {
  String error;

  LoginErrorState(this.error);
}
