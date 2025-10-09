import 'package:flutter/material.dart';
import 'package:multitasking/app/router/path_router.dart';
import 'package:multitasking/app/router/router.dart';
import 'package:multitasking/app/theme/app_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // navigation
      initialRoute: PathRouter.splash,
      onGenerateRoute: AppRouter.generateRoutes,
      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const Scaffold(body: Center(child: Text('Hello, World!'))),
    );
  }
}
