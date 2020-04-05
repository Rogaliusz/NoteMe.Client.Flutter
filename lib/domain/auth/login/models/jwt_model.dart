import 'package:json_annotation/json_annotation.dart';
import 'package:noteme/domain/users/models/user_model.dart';

part 'jwt_model.g.dart';

@JsonSerializable()
class Jwt {
  String id;
  String token;
  DateTime expires;
  User user;

  Jwt();

  factory Jwt.fromJson(Map<String, dynamic> json) => _$JwtFromJson(json);

  Map<String, dynamic> toJson() => _$JwtToJson(this);
}
