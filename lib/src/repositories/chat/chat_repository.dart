import 'package:chatgpt_front/src/models/chat_model.dart';

abstract class ChatRepository {
  Future<ChatModel> promptMessage(List<ChatModel> prompt);
}
