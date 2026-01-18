import 'package:equatable/equatable.dart';

import '../model/todo.dart';

final class RegisterState extends Equatable {
  const RegisterState({this.todo = const []});

  final List<Todo>? todo;

  RegisterState copyWith({List<Todo>? todo}) {
    return RegisterState(todo: todo ?? this.todo);
  }

  @override
  List<Object?> get props => [todo];
}
