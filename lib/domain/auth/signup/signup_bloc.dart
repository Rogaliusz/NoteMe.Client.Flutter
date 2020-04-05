import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:noteme/domain/auth/signup/states/signup_state.dart';
import 'package:noteme/framework/bloc/bloc_provider.dart';
import 'package:noteme/framework/web/api/api_endpoints.dart';
import 'package:noteme/framework/web/api/api_service.dart';

import 'events/signup_event.dart';

@injectable
class SignupBloc implements NoteMeBloc {
  final _eventController = new StreamController<SignupEvent>();
  final _stateController = new StreamController<SignupState>();

  final ApiService _apiService;

  Stream<SignupState> get stateStream => _stateController.stream;
  StreamSink<SignupEvent> get eventSink => _eventController.sink;

  SignupBloc(this._apiService) {
    _eventController.stream.listen(onData);
  }

  void onData(SignupEvent event) async {
    var json = event.toJson();

    var response = await _apiService.post(UsersEndpoint, json);
    if (response.isCorrect) {
      _stateController.sink.add(new SignupOkState());
    } else {
      _stateController.sink.add(new SignupErrorState(response.body));
    }
  }

  @override
  dispose() {
    _eventController.close();
    _stateController.close();
  }
}
