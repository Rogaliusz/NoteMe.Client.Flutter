// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginCommand _$LoginCommandFromJson(Map<String, dynamic> json) {
  return LoginCommand()
    ..email = json['email'] as String
    ..password = json['password'] as String;
}

Map<String, dynamic> _$LoginCommandToJson(LoginCommand instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
