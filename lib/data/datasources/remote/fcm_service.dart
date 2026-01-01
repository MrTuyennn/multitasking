import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' as foundation;

class FcmService {
  FirebaseMessaging get _firebaseMessaging => FirebaseMessaging.instance;

  Future<String?> getToken() async {
    try {
      await _firebaseMessaging.getInitialMessage();
      await _firebaseMessaging.setAutoInitEnabled(true);

      if (foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS) {
        String? apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken == null) {
          await Future<void>.delayed(const Duration(seconds: 3));
          apnsToken = await _firebaseMessaging.getAPNSToken();
        }
      }
      return _firebaseMessaging.getToken();
    } catch (e) {
      return "";
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
