import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/domain/notes/notes_repository.dart';
import 'package:noteme/framework/synchronizators/synchronization_repository.dart';
import 'package:noteme/framework/web/api/api_service.dart';
import 'package:noteme/framework/web/api/api_settings.dart';
import 'package:noteme/framework/workers/synchronization_worker.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ApiService _apiService;
  final ApiSettings _apiSettings;
  final NoteRepository _noteRepository;
  final SynchronizationRepository _synchronizationRepository;

  AuthenticationBloc(this._apiService, this._apiSettings, this._noteRepository,
      this._synchronizationRepository);

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
      _apiService.setToken(event.user.token);
      await SynchronizationWorker.start();
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      _apiSettings.loggedUser = null;
      await SynchronizationWorker.stop();
      await _noteRepository.clear();
      await _synchronizationRepository.clear();
      yield AuthenticationUnauthenticated();
    }
  }
}
