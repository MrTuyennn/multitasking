import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:multitasking/core/errors/failure.dart';
import 'package:multitasking/data/models/request/login_request.dart';
import 'package:multitasking/domain/dto/login_dto.dart';
import 'package:multitasking/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
  LoginBloc(this.loginUsecase) : super(LoginInitial()) {
    on<LoginSubmitted>(_loginSubmitted);
  }

  void _loginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final requestLogin = LoginRequest(
      email: event.email,
      password: event.password,
    );
    final result = await loginUsecase.call(requestLogin);
    result.fold(
      (failure) {
        emit(LoginFailure(failure: failure));
      },
      (data) {
        emit(LoginSuccess(data: data));
      },
    );
  }
}
