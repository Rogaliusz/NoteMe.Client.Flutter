import 'package:json_annotation/json_annotation.dart';

part 'signup_event.g.dart';

@JsonSerializable()
class SignupEvent {
  String email;
  String password;

  SignupEvent(this.email, this.password);

  factory SignupEvent.fromJson(Map<String, dynamic> json) =>
      _$SignupEventFromJson(json);

  Map<String, dynamic> toJson() => _$SignupEventToJson(this);
}
