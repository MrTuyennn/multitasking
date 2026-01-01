import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:multitasking/app/log/logger_service_impl.dart';

class FcmHandler {
  FirebaseMessaging get _firebaseMessaging => FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permission
    await requestPermission();

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification tap
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // Handle token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen(_handleTokenRefresh);
  }

  Future<void> requestPermission() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    // Handle background notification
    logger.d('Background message: ${message.messageId}');
  }

  void _handleForegroundMessage(RemoteMessage message) {
    // Show in-app notification
    logger.d('Foreground message: ${message.messageId}');
  }

  void _handleNotificationTap(RemoteMessage message) {
    // Navigate to specific screen
    logger.d('Notification tapped: ${message.messageId}');
  }

  void _handleTokenRefresh(String token) {
    // Update token in backend
    logger.d('Token refreshed: $token');
  }
}
