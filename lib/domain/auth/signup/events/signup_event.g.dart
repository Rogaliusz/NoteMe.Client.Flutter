// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupEvent _$SignupEventFromJson(Map<String, dynamic> json) {
  return SignupEvent(
    json['email'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$SignupEventToJson(SignupEvent instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
