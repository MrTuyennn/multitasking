import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multitasking/app/router/path_router.dart';
import 'package:multitasking/presentation/pages/auth/register/bloc/register_bloc.dart';
import 'package:multitasking/presentation/pages/auth/register/bloc/register_event.dart';
import 'package:multitasking/presentation/pages/auth/register/bloc/register_state.dart';
import 'package:multitasking/presentation/pages/auth/register/model/todo.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Register'),
                if (state.todo != null && state.todo!.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.todo?.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              PathRouter.detail,
                              arguments: state.todo?[index],
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 10,
                            children: [
                              Text(index.toString()),
                              Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.todo?[index].title ?? ''),
                                  Text(state.todo?[index].description ?? ''),
                                  Divider(),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<RegisterBloc>().add(
                                    RegisterRemoveTodo(index),
                                  );
                                },
                                icon: Icon(Icons.close),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                GestureDetector(
                  onTap: () {
                    context.read<RegisterBloc>().add(
                      RegisterAddTodo(
                        todo: Todo(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          title: 'nguyễn ngọc tuyên',
                          description: 'Mobile developer',
                        ),
                      ),
                    );
                  },
                  child: Text("thêm"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
