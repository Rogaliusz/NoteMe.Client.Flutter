import 'package:json_annotation/json_annotation.dart';

part 'signup_event.g.dart';

abstract class SignupEventBase {}

@JsonSerializable()
class SignupEvent extends SignupEventBase {
  String id;
  String email;
  String password;

  SignupEvent(this.email, this.password);

  factory SignupEvent.fromJson(Map<String, dynamic> json) =>
      _$SignupEventFromJson(json);

  Map<String, dynamic> toJson() => _$SignupEventToJson(this);
}
