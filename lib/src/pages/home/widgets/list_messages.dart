import 'package:chatgpt_front/src/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListMessages extends StatelessWidget {
  ListMessages({
    super.key,
    required ScrollController scrollCtrl,
    required List<ChatModel> messages,
  })  : _scrollCtrl = scrollCtrl,
        _messages = messages;

  final ScrollController _scrollCtrl;
  final List<ChatModel> _messages;
  final f = DateFormat('HH:mm');

  Color getColorContainer(ChatModel chat, BuildContext context) {
    if (chat.messageFrom == MessageFrom.assit) {
      return (Theme.of(context).colorScheme.secondaryContainer).withOpacity(.5);
    }

    return (Theme.of(context).colorScheme.primaryContainer).withOpacity(1);
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
                width: MediaQuery.of(context).size.width * 0.7,
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 1),
                decoration: BoxDecoration(
                  color: getColorContainer(_messages[index], context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      menssage.message,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          f.format(menssage.createdAt),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
