import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class FcmService {
  Future<void> init() async {
    try {
      // ✅ চেক করুন Firebase initialized আছে কিনা
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }
      
      // Permission request
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // Get initial message (app opened from terminated state)
      RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        _handleNotification(initialMessage);
      }

      // Foreground state
      FirebaseMessaging.onMessage.listen(_handleNotification);

      // Background/Opened state
      FirebaseMessaging.onMessageOpenedApp.listen(_handleNotification);

      // Background message handler
      FirebaseMessaging.onBackgroundMessage(_handleBackgroundNotification);
      
    } catch (e) {
      print('FCM initialization error: $e');
    }
  }

  void _handleNotification(RemoteMessage message) {
    String formattedMessage = ''' 
    Title: ${message.notification?.title} 
    Body: ${message.notification?.body}
    Data: ${message.data}''';

    print(formattedMessage);
    
    // TODO: Show local notification or update UI
  }

  Future<String?> getFcmToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }

  void onTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      print('FCM Token refreshed: $newToken');
      // TODO: Send new token to your server
    });
  }

  @pragma('vm:entry-point')
  static Future<void> _handleBackgroundNotification(RemoteMessage message) async {
    // এই মেথডটা static হতে হবে এবং @pragma annotation থাকতে হবে
    print('Background message: ${message.messageId}');
    // TODO: Handle background message
  }
}