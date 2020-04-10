import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:noteme/framework/bloc/event_provider.dart';

part 'login_event.g.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

@JsonSerializable()
class LoginButtonPressed extends LoginEvent {
  String email;
  String password;

  LoginButtonPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $email, password: $password }';

  factory LoginButtonPressed.fromJson(Map<String, dynamic> json) =>
      _$LoginButtonPressedFromJson(json);

  Map<String, dynamic> toJson() => _$LoginButtonPressedToJson(this);
}
