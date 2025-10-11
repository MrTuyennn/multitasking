import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multitasking/app/config/evn.dart';
import 'package:multitasking/app/l10n/generated/app_localizations.dart';
import 'package:multitasking/app/l10n/l10n.dart';
import 'package:multitasking/app/router/path_router.dart';
import 'package:multitasking/app/router/router.dart';
import 'package:multitasking/app/theme/app_theme.dart';

class App extends StatefulWidget {
  const App({super.key, required this.env});

  final AppConfigProvider env;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo ${widget.env}',
      // localization
      supportedLocales: L10n.all,
      locale: AppConfig.defaultLanguage,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // navigation
      initialRoute: PathRouter.splash,
      onGenerateRoute: AppRouter.generateRoutes,
      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Flutter Demo ${widget.env.baseUrl}"),
              Text("BaseUrl ${widget.env.appId}"),
            ],
          ),
        ),
      ),
    );
  }
}
