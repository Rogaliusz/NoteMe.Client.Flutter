// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginButtonPressed _$LoginButtonPressedFromJson(Map<String, dynamic> json) {
  return LoginButtonPressed(
    email: json['email'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$LoginButtonPressedToJson(LoginButtonPressed instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
