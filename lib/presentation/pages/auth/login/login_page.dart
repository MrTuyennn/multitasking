import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multitasking/presentation/pages/auth/login/bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                context.read<LoginBloc>().add(
                  LoginSubmitted(
                    email: 'nguyenngoctuyen188@gmail.com',
                    password: '11234',
                  ),
                );
              },
              child: Text("login page"),
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginSuccess) {
                  return Text(state.data.accessToken);
                }
                return Text('Login Error');
              },
            ),
          ],
        ),
      ),
    );
  }
}
