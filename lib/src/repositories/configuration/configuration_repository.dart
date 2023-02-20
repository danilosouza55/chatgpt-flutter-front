import 'package:chatgpt_front/src/models/configuration_model.dart';

abstract class ConfigurationRepository {
  Future<ConfigurationModel> getConfiguration();
  void saveConfiguration(String themeModeName);
}
