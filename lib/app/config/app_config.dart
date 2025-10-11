import 'package:multitasking/app/config/evn.dart';

enum Environment { PRODUCTION, STAGING, DEV }


class AppConfigManager {
  static AppConfigManager? _instance;
  Config? _config;

  static AppConfigManager get instance {
    _instance ??= AppConfigManager._();
    return _instance!;
  }

  AppConfigManager._();

  void setConfig(Config config) {
    _config = config;
  }

  Config get config => _config!;
}
