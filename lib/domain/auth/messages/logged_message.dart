import 'package:injectable/injectable.dart';
import 'package:noteme/framework/messages/message_handler.dart';
import 'package:noteme/framework/messages/message_model.dart';
import 'package:noteme/framework/web/api/api_service.dart';
import 'package:noteme/framework/web/api/api_settings.dart';
import 'package:noteme/framework/workers/synchronization_worker.dart';

class LoggedMessage extends Message {}

@injectable
@lazySingleton
class LoggedMessageHandler extends MessageHandler<LoggedMessage> {
  final ApiSettings _settings;
  final ApiService _service;

  LoggedMessageHandler(this._settings, this._service);

  @override
  Future<void> handle(LoggedMessage message) async {
    final user = _settings.loggedUser;

    if (user == null) {
      throw new Exception('User not logged!');
    }

    this._service.setToken(user.token);

    SynchronizationWorker.start();
  }
}
