part of 'splash_cubit.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}

final class SplashShowPage extends SplashState {
  final int page;
  final bool animate;

  const SplashShowPage({required this.page, this.animate = true});

  @override
  List<Object> get props => [page, animate];
}
