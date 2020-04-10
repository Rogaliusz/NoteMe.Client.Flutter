import 'package:json_annotation/json_annotation.dart';

part 'login_command.g.dart';

@JsonSerializable()
class LoginCommand {
  String email;
  String password;
}
