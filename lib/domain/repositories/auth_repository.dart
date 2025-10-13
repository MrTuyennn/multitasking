import 'package:fpdart/fpdart.dart';
import 'package:multitasking/core/errors/failure.dart';
import 'package:multitasking/data/models/request/login_request.dart';
import 'package:multitasking/data/models/response/login_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(LoginRequest request);
}
