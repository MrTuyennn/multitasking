import 'package:equatable/equatable.dart';

import '../model/todo.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class RegisterAddTodo extends RegisterEvent {
  final Todo? todo;
  const RegisterAddTodo({this.todo});
}

final class RegisterRemoveTodo extends RegisterEvent {
  final int index;
  const RegisterRemoveTodo(this.index);
}
