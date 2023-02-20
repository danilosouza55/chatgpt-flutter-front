// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:chatgpt_front/src/core/exceptions/repository_exception.dart';
import 'package:chatgpt_front/src/core/exceptions/unauthorized_exception.dart';
import 'package:chatgpt_front/src/core/rest_client/custom_dio.dart';
import 'package:chatgpt_front/src/models/chat_model.dart';
import 'package:dio/dio.dart';

import './chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final CustomDio _dio;

  ChatRepositoryImpl({
    required CustomDio dio,
  }) : _dio = dio;

  @override
  Future<ChatModel> promptMessage(String prompt) async {
    try {
      final response = await _dio.auth().post(
        '/completions',
        data: {
          'model': 'text-davinci-003',
          'prompt': prompt,
          'temperature': 0,
          'max_tokens': 1000,
          'top_p': 1,
          'frequency_penalty': 0.0,
          'presence_penalty': 0.0
        },
      );

      final data = ChatModel.fromMap(response.data);

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


// const url = "https://api.openai.com/v1/completions";

//       final response = await _dio.post(url,
//           data: {
//             'model': 'text-davinci-003',
//             'prompt': prompt,
//             'temperature': 0,
//             'max_tokens': 1000,
//             'top_p': 1,
//             'frequency_penalty': 0.0,
//             'presence_penalty': 0.0
//           },
//           options: Options(headers: {
//             'Authorization': 'Bearer ${AppConfig.getOpenAIAPIKey}',
//           }));

//       return response.data['choices'][0]['text'];
//     } catch (_) {
//       return 'Ocorreu um erro! Por favor, tente novamente';
//     }