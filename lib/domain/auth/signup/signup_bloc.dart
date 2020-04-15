import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/domain/auth/signup/states/signup_state.dart';
import 'package:noteme/framework/bloc/bloc_provider.dart';
import 'package:noteme/framework/web/api/api_endpoints.dart';
import 'package:noteme/framework/web/api/api_service.dart';
import 'package:uuid/uuid.dart';

import 'events/signup_event.dart';

@injectable
class SignupBloc extends Bloc<SignupEventBase, SignupState> {
  final ApiService _apiService;

  SignupBloc(this._apiService);

  @override
  SignupState get initialState => SignupInitializedState();

  @override
  Stream<SignupState> mapEventToState(SignupEventBase event) async* {
    if (event is SignupEvent) {
      event.id = Uuid().v1();

      var json = event.toJson();

      var response = await _apiService.post(UsersEndpoint, json);
      if (response.isCorrect) {
        yield new SignupOkState();
      } else {
        yield new SignupErrorState(response.body);
      }
    }

    yield SignupInitializedState();
  }
}
