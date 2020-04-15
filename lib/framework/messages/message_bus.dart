import 'package:injectable/injectable.dart';
import 'package:noteme/domain/auth/messages/logged_message.dart';
import 'package:noteme/framework/ioc/injection.iconfig.dart';
import 'package:noteme/framework/messages/message_handler.dart';
import 'package:noteme/framework/messages/message_model.dart';

@lazySingleton
@injectable
class MessageBus {
  final handlers = new Map<Type, List<MessageHandler>>();
  final subscriptions = new Map<Type, List<Function>>();

  MessageBus();

  Future<void> publish<TMessage extends Message>(TMessage message) async {
    invokeHandlers(message);
    invokeSubscriptions(message);
  }

  invokeHandlers<TMessage extends Message>(TMessage message) async {
    var messageHandlers = handlers[TMessage];
    if (messageHandlers == null || messageHandlers.length == 0) {
      return;
    }

    for (final handler in messageHandlers) {
      await handler.handle(message);
    }
  }

  invokeSubscriptions<TMessage extends Message>(TMessage message) async {
    var subs = subscriptions[TMessage];
    if (subs == null || subs.length == 0) {
      return;
    }
    for (final sub in subs) {
      sub(message);
    }
  }

  subscribe<TMessage extends Message>(Function onHandle) {
    if (!handlers.containsKey(TMessage)) {
      subscriptions[TMessage] = new List<Function>();
    }

    subscriptions[TMessage].add(onHandle);
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
