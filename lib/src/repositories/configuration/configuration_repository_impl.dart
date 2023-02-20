import 'package:chatgpt_front/src/models/configuration_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'configuration_repository.dart';

class ConfigurationRepositoryImpl implements ConfigurationRepository {
  final _keyThemeModeName = 'THEME_MODE_NAME';

  @override
  Future<ConfigurationModel> getConfiguration() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final configurationModel = ConfigurationModel(
      themeModeName: sharedPreferences.getString(_keyThemeModeName) ?? 'system',
    );

    return configurationModel;
  }

  @override
  void saveConfiguration(String themeModeName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(_keyThemeModeName, themeModeName);
  }
}
