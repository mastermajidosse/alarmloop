import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_state.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class NotificationCubit extends Cubit<NotificationState> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  bool _isInitialized = false;
  bool _timezoneInitzed = false;

  NotificationCubit()
      : flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin(),
        super(NotificationInitialState());

  Future<void> initializeNotifications() async {
    if (!_isInitialized) {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      final InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
      );
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
      _isInitialized = true;
    }
  }

  Future<void> initializeTimeZone() async {
    tzdata.initializeTimeZones();
    _timezoneInitzed = true;
    final String timeZoneName = 'Africa/Casablanca'; // Morocco time zone
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }
}
