import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:noteme/domain/auth/login/events/login_event.dart';
import 'package:noteme/domain/auth/login/models/jwt_model.dart';
import 'package:noteme/domain/auth/login/states/logged_state.dart';
import 'package:noteme/framework/bloc/bloc_provider.dart';
import 'package:noteme/framework/web/api/api_endpoints.dart';
import 'package:noteme/framework/web/api/api_service.dart';
import 'package:noteme/framework/web/api/api_settings.dart';
import 'package:noteme/theme/services/loader_service.dart';

@injectable
class LoginBloc implements NoteMeBloc {
  final _loginStateController = new StreamController<LoginEvent>();
  final _loggedStateController = new StreamController<LoggedState>();

  final LoaderService _loaderService;
  final ApiSettings _apiSettings;
  final ApiService _apiService;

  StreamSink<LoginEvent> get login => _loginStateController.sink;
  Stream<LoggedState> get logged => _loggedStateController.stream;

  LoginBloc(this._loaderService, this._apiSettings, this._apiService) {
    _loginStateController.stream.listen(onData);
  }

  void onData(LoginEvent event) async {
    var json = event.toJson();

    _loaderService.setOperation(true);
    var response = await _apiService.post(LoginEndpoint, json);
    _loaderService.setOperation(false);

    if (response.isCorrect) {
      var jwt = Jwt.fromJson(response.json);

      _apiSettings.loggedUser = jwt;
      _loggedStateController.add(new LoginOkState(jwt));
    } else {
      _loggedStateController.add(new LoginErrorState(response.body));
    }
  }

  @override
  dispose() {
    _loginStateController.close();
    _loggedStateController.close();
  }
}
