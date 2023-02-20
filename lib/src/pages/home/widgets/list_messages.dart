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
        return Row(
          children: [
            if (_messages[index].messageFrom == MessageFrom.me) const Spacer(),
            // Messagem
            Container(
              margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              width: MediaQuery.of(context).size.width * 0.6,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: getColorContainer(_messages[index], context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _messages[index].message,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        );
      },
    );
  }
}
