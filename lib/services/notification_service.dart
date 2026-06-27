import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(android: androidInit);

    await _plugin.initialize(settings);
  }

  Future<void> showHighTempNotification(double temp, String ville) async {
    if (temp <= 33) return;

    const androidDetails = AndroidNotificationDetails(
      'canal_alerte',
      'Alertes météo',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _plugin.show(
      0,
      '🔥 Alerte chaleur',
      'Il fait ${temp.toStringAsFixed(0)}°C à $ville',
      details,
    );
  }
}