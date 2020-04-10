import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/framework/web/api/api_settings.dart';
import 'package:noteme/framework/workers/synchronization_worker.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ApiSettings _apiSettings;

  AuthenticationBloc(this._apiSettings);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    final user = _apiSettings.loggedUser;

    if (event is AppStarted) {
      if (user != null) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      _apiSettings.loggedUser = event.user;
      await SynchronizationWorker.start();
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      _apiSettings.loggedUser = null;
      yield AuthenticationUnauthenticated();
    }
  }
}
