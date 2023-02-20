import 'package:chatgpt_front/src/pages/home/home_page.dart';
import 'package:chatgpt_front/src/repositories/chat/chat_repository.dart';
import 'package:chatgpt_front/src/repositories/chat/chat_repository_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        AutoBind.factory<ChatRepository>(ChatRepositoryImpl.new),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
      ];
}
