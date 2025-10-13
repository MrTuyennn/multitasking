import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multitasking/app/extensions/build_context_extension.dart';
import 'package:multitasking/app/log/logger_service_impl.dart';
import 'package:multitasking/core/di/di.dart';
import 'package:multitasking/presentation/pages/auth/login/bloc/login_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = getIt<LoginBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: _loginBloc,
        listener: (context, state) {
          // logger.d(state); // "LoginLoading"
          // if (state is LoginLoading) {
          // } else if (state is LoginSuccess) {
          //   logger.d(state.data);
          // }
        },
        builder: (context, state) {
          logger.d(state);
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(context.l10n.txt_hello),
                GestureDetector(
                  onTap: () {
                    _loginBloc.add(
                      LoginSubmitted(
                        email: "tuyen@gmail.comaaaaa",
                        password: "123456",
                      ),
                    );
                  },
                  child: Text('login'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
