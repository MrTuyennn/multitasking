import './dtos/refresh_token_response.dart';

const accessTokenSecretKey = 'accessTokenSecretKey@RestClient';
const accessProfileTokenSecretKey = 'accessProfileTokenSecretKey@RestClient';
const refreshAccessTokenSecretKey = 'refreshAccessTokenSecretKey@RestClient';

abstract interface class ITokenService {
  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<void> saveToken(String accessToken, String refreshToken);

  Future<void> clearToken();

  Future<RefreshTokenResponse> refreshToken(String? refreshToken);
}
