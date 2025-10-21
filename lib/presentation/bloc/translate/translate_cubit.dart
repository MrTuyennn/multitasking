import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'translate_state.dart';

@injectable
class TranslateCubit extends Cubit<TranslateState> {
  TranslateCubit() : super(TranslateInitial());

  void changeTranslate(Locale locale) => emit(ChangeTranslate(locale: locale));
  
}
