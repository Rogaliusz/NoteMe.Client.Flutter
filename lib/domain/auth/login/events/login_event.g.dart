// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginEvent _$LoginEventFromJson(Map<String, dynamic> json) {
  return LoginEvent(
    json['email'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$LoginEventToJson(LoginEvent instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
