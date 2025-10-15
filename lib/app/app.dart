import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multitasking/app/l10n/generated/app_localizations.dart';
import 'package:multitasking/app/l10n/l10n.dart';
import 'package:multitasking/app/router/path_router.dart';
import 'package:multitasking/app/router/router.dart';
import 'package:multitasking/app/theme/app_theme.dart';
import 'package:multitasking/core/di/di.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo ',
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
      navigatorKey: getIt<GlobalKey<NavigatorState>>(
        instanceName: 'navigatorKey',
      ),
      initialRoute: PathRouter.splash,
      onGenerateRoute: AppRouter.generateRoutes,
      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
