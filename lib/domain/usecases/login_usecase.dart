import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:multitasking/core/errors/failure.dart';
import 'package:multitasking/data/models/request/login_request.dart';
import 'package:multitasking/domain/dto/login_dto.dart';
import 'package:multitasking/domain/repositories/auth_repository.dart';

@injectable
class LoginUsecase {
  final AuthRepository _authRepository;
  LoginUsecase(this._authRepository);

  Future<Either<Failure, LoginDto>> call(LoginRequest request) {
    return _authRepository.login(request).then((value) {
      return value.map((response) => LoginDto.fromLoginResponse(response));
    });
  }
}
