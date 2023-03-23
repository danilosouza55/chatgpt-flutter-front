import 'package:chatgpt_front/src/models/chat_model.dart';
import 'package:flutter/material.dart';

class ListMessages extends StatelessWidget {
  const ListMessages({
    super.key,
    required ScrollController scrollCtrl,
    required List<ChatModel> messages,
  })  : _scrollCtrl = scrollCtrl,
        _messages = messages;

  final ScrollController _scrollCtrl;
  final List<ChatModel> _messages;

  Color getColorContainer(ChatModel chat, BuildContext context) {
    if (chat.messageFrom == MessageFrom.bot) {
      return Theme.of(context).colorScheme.primaryContainer;
    }

    return Theme.of(context).colorScheme.secondaryContainer;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollCtrl,
      itemCount: _messages.length,
      itemBuilder: (_, int index) {
        final menssage = _messages[index];

        return Visibility(
          visible: !(menssage.messageFrom == MessageFrom.bot),
          child: Row(
            children: [
              if (menssage.messageFrom == MessageFrom.me) const Spacer(),
              // Messagem
              Container(
                margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                width: MediaQuery.of(context).size.width * 0.6,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: getColorContainer(_messages[index], context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SelectableText(
                  menssage.message,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
