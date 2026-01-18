import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multitasking/presentation/pages/auth/register/bloc/register_event.dart';
import 'package:multitasking/presentation/pages/auth/register/bloc/register_state.dart';

import '../model/todo.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<RegisterAddTodo>(_registerAddTodo);
    on<RegisterRemoveTodo>(_registerRemoveTodo);
  }

  void _registerRemoveTodo(
    RegisterRemoveTodo event,
    Emitter<RegisterState> emit,
  ) {
    if (state.todo != null && state.todo!.isNotEmpty) {
      final todos = List<Todo>.from(state.todo ?? []);
      todos.removeAt(event.index);
      emit(state.copyWith(todo: todos));
    }
  }

  void _registerAddTodo(RegisterAddTodo event, Emitter<RegisterState> emit) {
    Todo newTodo = event.todo ?? Todo();
    List<Todo> addTodo = [...state.todo ?? [], newTodo];
    emit(state.copyWith(todo: addTodo));
  }
}
