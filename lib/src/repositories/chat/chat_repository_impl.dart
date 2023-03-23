import 'dart:developer';

import 'package:chatgpt_front/src/core/exceptions/repository_exception.dart';
import 'package:chatgpt_front/src/core/exceptions/unauthorized_exception.dart';
import 'package:chatgpt_front/src/core/rest_client/custom_dio.dart';
import 'package:chatgpt_front/src/models/chat_model.dart';
import 'package:dio/dio.dart';

import './chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final CustomDio _dio;
  final String palavrasChaves = ';PALAVRA CHAVE: SOFTWARE SETAERP';

  ChatRepositoryImpl({
    required CustomDio dio,
  }) : _dio = dio;

  @override
  Future<ChatModel> promptMessage(List<ChatModel> prompt) async {
    try {
      final response = await _dio.auth().post(
        '/chat/completions',
        data: {
          'model': 'gpt-3.5-turbo',
          'max_tokens': 600,
          "temperature": 0.7,
          "top_p": 1,
          "n": 1,
          'messages': prompt
              .map((chat) => {
                    "role": chat.messageFrom == MessageFrom.me
                        ? 'user'
                        : chat.messageFrom == MessageFrom.bot
                            ? 'system'
                            : 'assistant',
                    "content": chat.messageFrom == MessageFrom.me
                        ? '${chat.message} $palavrasChaves'
                        : chat.message,
                  })
              .toList(),
        },
      );

      final data = ChatModel.fromMap(response.data['choices'][0]);

      return data;
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 403) {
        log('Permissão negada', error: e, stackTrace: s);
        throw UnauthorizedException();
      }
      log('Erro ao realizar o envio da mensagem', error: e, stackTrace: s);
      throw RepositoryException(
        message: 'Erro ao enviar a mensagem',
      );
    }
  }
}
