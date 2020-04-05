abstract class SignupState {}

class SignupOkState extends SignupState {}

class SignupErrorState extends SignupState {
  String error;

  SignupErrorState(this.error);
}
