import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:multitasking/app/router/path_router.dart';
import 'package:multitasking/data/datasources/preference/shared_preference.dart';

class AuthInterceptor extends Interceptor {
  final SharedPreference _sessionService;
  final GlobalKey<NavigatorState> _navigatorKey;

  AuthInterceptor(this._sessionService, this._navigatorKey);

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
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle 401 Unauthorized responses (but skip for auth endpoints and change password)
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.startsWith('/auth/') &&
        !err.requestOptions.path.contains('/users/change-password')) {
      _handleTokenExpired();
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
