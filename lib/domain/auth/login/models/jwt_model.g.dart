// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Jwt _$JwtFromJson(Map<String, dynamic> json) {
  return Jwt()
    ..id = json['id'] as String
    ..token = json['token'] as String
    ..expires = json['expires'] == null
        ? null
        : DateTime.parse(json['expires'] as String)
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$JwtToJson(Jwt instance) => <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'expires': instance.expires?.toIso8601String(),
      'user': instance.user,
    };
