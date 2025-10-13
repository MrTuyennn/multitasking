import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:multitasking/core/errors/error_handler.dart';
import 'package:multitasking/core/errors/failure.dart';
import 'package:multitasking/data/models/request/login_request.dart';
import 'package:multitasking/data/models/response/login_response.dart';
import 'package:multitasking/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest request) async {
    try {
      LoginResponse res = LoginResponse(
        accessToken: "hfsjdhfjshdhfsjd",
        tokenType: "tokenType",
        expiresIn: 1,
      );
      await Future.delayed(Duration(seconds: 1));
      return Right(res);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }
}
