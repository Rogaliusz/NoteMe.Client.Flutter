import 'package:noteme/framework/messages/message_model.dart';

abstract class MessageHandler<TMessage extends Message> {
  Future<void> handle(TMessage message);
}
