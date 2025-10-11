import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:multitasking/app/config/app_config.dart';

class AppConfigProvider {
  final String socketBaseUrl;
  final String baseUrl;
  final String apiKey;
  //Agora key
  final String appChatKey;
  final String appId;
  final String webBaseUrl;
  final String clientId;
  //

  AppConfigProvider({
    required this.socketBaseUrl,
    required this.baseUrl,
    required this.apiKey,
    required this.appChatKey,
    required this.appId,
    required this.webBaseUrl,
    required this.clientId,
  });

  static Future<AppConfigProvider> loadConfig(String? param) async {
    var env = Environment.DEV;
    if (param?.toUpperCase() == Environment.DEV.name) {
      await dotenv.load(fileName: "env/develop.env");
    } else if (param?.toUpperCase() == Environment.STAGING.name) {
      env = Environment.STAGING;
      await dotenv.load(fileName: "env/staging.env");
    } else {
      env = Environment.PRODUCTION;
      await dotenv.load(fileName: "env/production.env");
    }
    final config = AppConfigProvider(
      baseUrl: dotenv.env['BASE_URL'] ?? '',
      socketBaseUrl: dotenv.env['SOCKET_BASE_URL'] ?? '',
      apiKey: dotenv.env['API_KEY'] ?? '',
      appChatKey: dotenv.env['APP_CHAT_KEY'] ?? '',
      appId: dotenv.env['APP_ID'] ?? '',
      webBaseUrl: dotenv.env['WEB_BASE_URL'] ?? '',
      clientId: dotenv.env['APPLE_CLIENT_ID'] ?? '',
    );
    return config;
    // return AppConfig(appConfigProvider: config, env: env);
  }
}
