import 'package:chatgpt_front/src/core/rest_client/custom_dio.dart';
import 'package:chatgpt_front/src/core/stores/app_store.dart';
import 'package:chatgpt_front/src/pages/configuration/configuration_page.dart';
import 'package:chatgpt_front/src/pages/home/home_module.dart';
import 'package:chatgpt_front/src/pages/splash/splash.dart';
import 'package:chatgpt_front/src/repositories/configuration/configuration_repository.dart';
import 'package:chatgpt_front/src/repositories/configuration/configuration_repository_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        AutoBind.singleton(CustomDio.new),
        AutoBind.singleton(AppStore.new),
        AutoBind.factory<ConfigurationRepository>(
          ConfigurationRepositoryImpl.new,
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const Splash()),
        ModuleRoute('/home', module: HomeModule()),
        ChildRoute(
          '/config',
          child: (context, args) => const ConfigurationPage(),
        )
      ];
}
