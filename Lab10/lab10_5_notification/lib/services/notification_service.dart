import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Service responsible for handling local notifications.
///
/// This class separates notification logic from UI.
///
/// Responsibilities:
/// - Initialize notification plugin
/// - Request permission
/// - Show notifications
class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// Initialize notification plugin.
  ///
  /// Must be called before using notification functions.
  Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _plugin.initialize(settings: settings);

    // Request notification permission
    // for Android 13+
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  /// Display a local notification.
  Future<void> showNotification({
    required String title,

    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'default_channel',

          'Default Notification',

          channelDescription: 'Application notifications',

          importance: Importance.high,

          priority: Priority.high,
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await _plugin.show(
      id: 1,

      title: title,

      body: body,

      notificationDetails: details,
    );
  }
}
