import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String> getToken() async {
    try {
      await _firebaseMessaging.getInitialMessage();
      await _firebaseMessaging.setAutoInitEnabled(true);
      return await _firebaseMessaging.getToken() ?? "";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
