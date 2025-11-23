import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multitasking/app/app.dart';
import 'package:multitasking/app/bloc/multi_bloc.dart';
import 'package:multitasking/app/config/app_config.dart';
import 'package:multitasking/app/config/evn.dart';
import 'package:multitasking/app/log/logger_service_impl.dart';
import 'package:multitasking/core/di/di.dart';
import 'package:multitasking/data/datasources/remote/fcm_handler.dart';
import 'package:multitasking/data/datasources/remote/fcm_service.dart';
import 'package:multitasking/firebase_options_dev.dart' as dev;
import 'package:multitasking/firebase_options_prod.dart' as prod;
import 'package:multitasking/firebase_options_stag.dart' as stg;

void main() async {
  await configureDependencies();
  await initializeFirebaseApp(AppConfigManager.instance.config);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(MultiBloc(child: App()));
}

Future<void> initializeFirebaseApp(Config config) async {
  final firebaseOptions = switch (config.env) {
    Environment.DEV => dev.DefaultFirebaseOptions.currentPlatform,
    Environment.STAGING => stg.DefaultFirebaseOptions.currentPlatform,
    Environment.PRODUCTION => prod.DefaultFirebaseOptions.currentPlatform,
  };
  await Firebase.initializeApp(options: firebaseOptions);
  final fcmHandler = getIt<FcmHandler>();
  await fcmHandler.requestPermission();
  final fcmService = getIt<FcmService>();
  String token = await fcmService.getToken();
  logger.d(token);
}
