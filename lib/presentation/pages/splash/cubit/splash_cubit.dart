import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Timer? _timer;

  void start() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 3), () {
      emit(const SplashShowPage(page: 1, animate: true));
    });
  }

  void goToPage(int page, {bool animate = true}) {
    emit(SplashShowPage(page: page, animate: animate));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
