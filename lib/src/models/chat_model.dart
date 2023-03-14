import 'dart:convert';

class ChatModel {
  final String message;
  final MessageFrom messageFrom;

  ChatModel({
    required this.message,
    required this.messageFrom,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'messageFrom': MessageFrom.bot,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      message: (map['message']['content'] as String).replaceAll("\n", ''),
      messageFrom: MessageFrom.assit,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum MessageFrom { me, bot, assit }
