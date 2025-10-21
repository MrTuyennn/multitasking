part of 'translate_cubit.dart';

sealed class TranslateState extends Equatable {
  const TranslateState();

  @override
  List<Object> get props => [];
}

final class TranslateInitial extends TranslateState {}

final class ChangeTranslate extends TranslateState {
  final Locale locale;

  const ChangeTranslate({required this.locale});

  @override
  List<Object> get props => [locale];
}
