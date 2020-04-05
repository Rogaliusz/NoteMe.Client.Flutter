import 'package:json_annotation/json_annotation.dart';
import 'package:noteme/framework/bloc/event_provider.dart';

part 'login_event.g.dart';

@JsonSerializable()
class LoginEvent implements NoteMeEvent {
  String email;
  String password;

  LoginEvent(this.email, this.password);

  factory LoginEvent.fromJson(Map<String, dynamic> json) =>
      _$LoginEventFromJson(json);

  Map<String, dynamic> toJson() => _$LoginEventToJson(this);
}
