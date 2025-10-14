import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:multitasking/core/interceptors/auth_interceptor.dart';
import 'package:multitasking/data/datasources/preference/shared_preference.dart';
import 'package:multitasking/data/datasources/remote/fcm_handler.dart';
import 'package:multitasking/data/datasources/remote/fcm_service.dart';

@module
abstract class DiModule {
  @lazySingleton
  FcmService get fcmService => FcmService();

  @lazySingleton
  FcmHandler get fcmHandler => FcmHandler();

  @lazySingleton
  Dio dio(
    SharedPreference sharePreference,
    @Named('navigatorKey') GlobalKey<NavigatorState> navigatorKey,
  ) {
    final dio = Dio();
    dio.interceptors.addAll([
      AuthInterceptor(sharePreference, navigatorKey),
      //DioNetworkLogger(),
    ]);
    return dio;
  }

  @Named('baseUrl')
  String baseUrl() => dotenv.env['BASE_URL'] ?? '';

  @preResolve
  @lazySingleton
  Future<FlutterSecureStorage> secureStorage() async =>
      const FlutterSecureStorage();

  @Named('navigatorKey')
  @lazySingleton
  GlobalKey<NavigatorState> navigatorKey() => GlobalKey<NavigatorState>();
}
