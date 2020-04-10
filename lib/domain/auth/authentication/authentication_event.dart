import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:noteme/domain/auth/login/models/jwt_model.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final Jwt user;

  LoggedIn(this.user);
}

class LoggedOut extends AuthenticationEvent {}
