import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multitasking/app/app.dart';
import 'package:multitasking/app/config/app_config.dart';
import 'package:multitasking/app/config/evn.dart';
import 'package:multitasking/firebase_options_dev.dart' as dev;
import 'package:multitasking/firebase_options_prod.dart' as prod;
import 'package:multitasking/firebase_options_stag.dart' as stg;

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebaseApp(AppConfigManager.instance.config);
  runApp(App());
}

Future<void> initializeFirebaseApp(Config config) async {
  final firebaseOptions = switch (config.env) {
    Environment.DEV => dev.DefaultFirebaseOptions.currentPlatform,
    Environment.STAGING => stg.DefaultFirebaseOptions.currentPlatform,
    Environment.PRODUCTION => prod.DefaultFirebaseOptions.currentPlatform,
  };
  await Firebase.initializeApp(options: firebaseOptions);
}
