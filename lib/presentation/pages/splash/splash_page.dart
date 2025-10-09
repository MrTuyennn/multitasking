import 'package:flutter/material.dart';
import 'package:multitasking/app/extensions/build_context_extension.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(context.l10n.txt_hello)));
  }
}
