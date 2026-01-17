import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../data/datasources/preference/shared_preference.dart';
import './dtos/refresh_token_response.dart';
import './itoken_service.dart';

@LazySingleton(as: ITokenService)
class TokenService implements ITokenService {
  TokenService(@Named('tokenDio') this._dio, this._sharedPreference);
  final SharedPreference _sharedPreference;
  final Dio _dio;

  @override
  Future<void> clearToken() {
    return Future.wait([_sharedPreference.clearToken()]);
  }

  @override
  Future<String?> getAccessToken() async {
    final accessToken = await _sharedPreference.getToken();
    return accessToken;
  }

  @override
  Future<String?> getRefreshToken() async {
    final refreshAccessToken = await _sharedPreference.getToken();
    return refreshAccessToken;
  }

  @override
  Future<RefreshTokenResponse> refreshToken(String? refreshToken) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/v1/auth/refresh-token',
      data: {"refreshToken": refreshToken},
    );
    if (response.statusCode == 200) {
      return RefreshTokenResponse.fromJson(response.data ?? {});
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
      );
    }
  }

  @override
  Future<void> saveToken(String accessToken, String refreshToken) {
    return _sharedPreference.saveToken(accessToken);
  }
}
