import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multitasking/core/di/di.dart';
import 'package:multitasking/presentation/bloc/translate/translate_cubit.dart';
import 'package:multitasking/presentation/pages/auth/login/bloc/login_bloc.dart';

class MultiBloc extends StatelessWidget {
  const MultiBloc({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LoginBloc>()),
        BlocProvider(create: (context) => getIt<TranslateCubit>()),
      ],
      child: child,
    );
  }
}
