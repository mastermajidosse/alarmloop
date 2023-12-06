import 'dart:async';

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
  AudioPlayer audioPlayer = AudioPlayer();
  late DateTime _alarmTime;

  NotificationCubit()
      : flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin(),
        super(NotificationInitialState());

  Future<void> initializeNotifications() async {
    if (!_isInitialized) {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/launcher_icon');
      final InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
      );
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
      _isInitialized = true;
    }
  }

  Future<void> scheduleAlarm(
      DateTime alarmTime, String sound, int index, int loopInterval) async {
    // Schedule the first notification
    // await scheduleNotification(
    //     index, 'it\'s Time', 'Ringing ⏰', alarmTime, sound);

    Timer? periodicTimer;

    // Schedule additional notifications with the specified interval
    periodicTimer = Timer.periodic(Duration(minutes: loopInterval), (timer) async {
      final additionalNotificationTime =
          DateTime.now().add(Duration(minutes: loopInterval));
      await scheduleNotification(
        timer.tick, // Use tick as an index for additional notifications
        'it\'s Time ⏰',
        'Ringing ⏰',
        additionalNotificationTime,
        sound,
      );

      String audioPath = 'assets/sounds/$sound.mp3';
      print("audioPath $audioPath");
      await playMusic(sound);

      // You can add a condition to cancel the timer if needed
      if (userCancelledNotification()) {
        periodicTimer?.cancel();
      }
    });
  }

  bool userCancelledNotification() {
    return false;
  }

  // Future<void> scheduleAlarm(DateTime alarmTime, sound,index,loopInterval) async {
  //   _alarmTime = alarmTime;

  //   // Schedule the first notification
  //   await scheduleNotification(index, 'it\'s Time', 'Ringing ⏰', alarmTime, sound);

  //   // Schedule additional notifications with a 10-minute interval
  //   for (int i = 1; i <= 100; i++) {
  //     final additionalNotificationTime =
  //         _alarmTime.add(Duration(minutes: loopInterval * i));

  //     await scheduleNotification(
  //         i, 'it\'s Time ⏰', 'Ringing ⏰', additionalNotificationTime, sound);

  //     String audioPath = 'assets/sounds/${sound}.mp3';
  //     print("audioPath $audioPath");
  //     await playMusic(sound);
  //   }
  // }

  Future<void> playMusic(String audioPath) async {
    // await audioPlayer.setSourceUrl(audioPath);
    await audioPlayer.play(UrlSource(audioPath));
  }

  Future<void> scheduleNotification(
    int id,
    String title,
    String body,
    DateTime scheduledTime,
    sound,
  ) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          id.toString(),
          'new channel',
          channelShowBadge: true,
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
          // channelDescription: 'TRYING TO PUSH UU',
          sound: RawResourceAndroidNotificationSound(sound),
          icon: 'launcher_icon',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'notification_$id',
    );
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
