import 'package:alarmloop/core/constant.dart';
import 'package:alarmloop/utils/style.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_state.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class NotificationCubit extends Cubit<NotificationState> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  bool _isInitialized = false;
  bool timezoneInit = false;
  late DateTime _alarmTime;

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

  Future<void> scheduleAlarm(DateTime alarmTime) async {
    _alarmTime = alarmTime;
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Alarm',
      'TIME TIME TIME',
      tz.TZDateTime.from(alarmTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel_id',
          'Alarm Channel',
          channelShowBadge: true, // Add this line
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          channelDescription: 'TRYING TO PUSH UU',
           sound: RawResourceAndroidNotificationSound('alarm_sound'),
          icon: 'launcher_icon',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'first_notification',
    );

    for (int i = 1; i <= 2; i++) {
      // Calculate the time for additional notification
      final additionalNotificationTime =
          _alarmTime.subtract(Duration(minutes: 2 * i));

      await flutterLocalNotificationsPlugin.zonedSchedule(
        i,
        'Alarm',
        'Come on....',
        tz.TZDateTime.from(additionalNotificationTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'alarm_channel_id',
            'Alarm Channel',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'additional_notification_$i',
      );
     AudioService().playSound(Constants.sound );
    }
  }

  Future<void> initializeTimeZone() async {
    if (!timezoneInit) {
      tzdata.initializeTimeZones();
      final String timeZoneName = 'Africa/Casablanca'; // Morocco time zone
      tz.setLocalLocation(tz.getLocation(timeZoneName));
      timezoneInit = true;
    }
  }
}


class AudioService {
    
      AudioService._();
    
      static final AudioService _instance = AudioService._();
    
      factory AudioService() {
        return _instance;
      }
    
      void playSound(AssetSource assetSource) async{
          AudioPlayer().play(assetSource, mode: PlayerMode.lowLatency); // faster play low latency eg for a game...
      }
    }