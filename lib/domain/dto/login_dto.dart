import 'package:multitasking/data/models/response/login_response.dart';

class LoginDto {
  final String accessToken;
  final String tokenType;
  final int expiresIn;

  LoginDto({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory LoginDto.fromLoginResponse(LoginResponse response) => LoginDto(
    accessToken: response.accessToken,
    tokenType: response.tokenType,
    expiresIn: response.expiresIn,
  );
}
