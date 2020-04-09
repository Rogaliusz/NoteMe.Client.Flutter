import 'package:injectable/injectable.dart';
import 'package:noteme/domain/auth/messages/logged_message.dart';
import 'package:noteme/framework/ioc/injection.iconfig.dart';
import 'package:noteme/framework/messages/message_handler.dart';
import 'package:noteme/framework/messages/message_model.dart';

@lazySingleton
@injectable
class MessageBus {
  final handlers = new Map<Type, List<MessageHandler>>();

  MessageBus();

  Future<void> publish<TMessage extends Message>(TMessage message) async {
    var messageHandlers = handlers[TMessage];
    if (messageHandlers == null || messageHandlers.length == 0) {
      return;
    }

    for (final handler in messageHandlers) {
      await handler.handle(message);
    }
  }

  registerHandlers() {
    _registerHandler<LoggedMessageHandler, LoggedMessage>();
  }

  _registerHandler<THandler extends MessageHandler<TMessage>,
      TMessage extends Message>() {
    final handler = getIt<THandler>();
    _register<TMessage>(handler);
  }

  _register<TMessage extends Message>(MessageHandler<TMessage> handler) {
    if (!handlers.containsKey(TMessage)) {
      handlers[TMessage] = new List<MessageHandler<TMessage>>();
    }

    handlers[TMessage].add(handler);
  }
}
