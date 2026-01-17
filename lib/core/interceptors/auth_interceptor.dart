import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:multitasking/app/router/path_router.dart';
import 'package:multitasking/data/datasources/preference/shared_preference.dart';

import '../errors/token/itoken_service.dart';

class AuthInterceptor extends Interceptor {
  final SharedPreference _sessionService;
  final GlobalKey<NavigatorState> _navigatorKey;
  final Dio _dio;
  final ITokenService _tokenService;

  AuthInterceptor(
    this._sessionService,
    this._navigatorKey,
    this._dio,
    this._tokenService,
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Skip auth header for auth endpoints
    if (options.path.startsWith('/auth/')) {
      handler.next(options);
      return;
    }

    // Add Bearer token for other endpoints
    final authHeader = _sessionService.getToken();
    options.headers['Authorization'] = authHeader;
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized responses (but skip for auth endpoints and change password)
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.startsWith('/auth/') &&
        !err.requestOptions.path.contains('/users/change-password')) {
      final token = await _sessionService.getToken();

      try {
        final newToken = await _tokenService
            .refreshToken(token)
            .then((value) => value.data.accessToken);
        if (newToken != '') {
          await _sessionService.saveToken(newToken);

          // Retry request
          final options = err.requestOptions;
          options.headers['Authorization'] = newToken;
          final cloneReq = await _dio.fetch(options);

          handler.resolve(cloneReq);
        } else {
          _handleTokenExpired();
        }
      } on DioException catch (_) {
        _handleTokenExpired();
      }
    }

    handler.next(err);
  }

  void _handleTokenExpired() async {
    // Clear session
    await _sessionService.clearToken();

    // Navigate to login
    final navigator = _navigatorKey.currentState;
    if (navigator != null) {
      navigator.pushNamedAndRemoveUntil(PathRouter.login, (route) => false);
    }
  }
}
