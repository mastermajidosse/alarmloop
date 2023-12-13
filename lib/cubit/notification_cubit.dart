// import 'dart:async';

// import 'package:alarmloop/core/constant.dart';
// import 'package:alarmloop/utils/style.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:bloc/bloc.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'notification_state.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tzdata;

// class NotificationCubit extends Cubit<NotificationState> {
//   // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   bool _isInitialized = false;
//   bool timezoneInit = false;
//   AudioPlayer audioPlayer = AudioPlayer();

//   NotificationCubit()
//       : flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin(),
//         super(NotificationInitialState());

//   Future<void> initializeNotifications() async {
//     if (!_isInitialized) {
//       const AndroidInitializationSettings initializationSettingsAndroid =
//           AndroidInitializationSettings('@mipmap/launcher_icon');

//       final InitializationSettings initializationSettings =
//           InitializationSettings(
//         android: initializationSettingsAndroid,
//       );
//       await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//       _isInitialized = true;
//     }
//   }

//   Future<void> scheduleAlarm(
//       DateTime alarmTime, String sound, int index, String loopInterval) async {
//     if (loopInterval == '1 min') {
//       await scheduleNotification(
//         index,
//         'it\'s Time ⏰',
//         'Ringing ⏰',
//         RepeatInterval.everyMinute,
//         sound,
//       );
//     } else if (loopInterval == '1 h') {
//       await scheduleNotification(
//         index,
//         'it\'s Time ⏰',
//         'Ringing ⏰',
//         RepeatInterval.hourly,
//         sound,
//       );
//     } else if (loopInterval == '20 min') {
//       await scheduleNotification(
//         index,
//         'it\'s Time ⏰',
//         'Ringing ⏰',
//         RepeatInterval.everyMinute,
//         sound,
//       );
//     } else {
//       print('Get out from the stack');
//     }
//   }

//   // Future cancelN(id) async {
//   //   await flutterLocalNotificationsPlugin.cancel(id);
//   //   print('the notification has been canceld successfully $id');
//   // }

//   // static tz.TZDateTime _scheduleDaily(Time time) {
//   //   final now = tz.TZDateTime.now(tz.local);
//   //   final scheduledDate = tz.TZDateTime(
//   //     tz.local,
//   //     now.year,
//   //     now.month,
//   //     now.day,
//   //     time.hour,
//   //     time.minute,
//   //     time.second,
//   //   );

//   //   return scheduledDate.isBefore(now)
//   //       ? scheduledDate.add(const Duration(days: 1))
//   //       : scheduledDate;
//   // }

//   // Future<void> scheduleTenMinuteNotifications(
//   //   int id,
//   //   DateTime startTime,
//   //   String title,
//   //   String body,
//   //   String sound,
//   // ) async {
//   //   final notificationDetails = NotificationDetails(
//   //     android: AndroidNotificationDetails(
//   //       id.toString(),
//   //       "Channel Id $id",
//   //       channelShowBadge: true,
//   //       importance: Importance.high,
//   //       priority: Priority.high,
//   //       playSound: true,
//   //       ongoing: true, // Set as ongoing to make it persistent
//   //       autoCancel: false, // Set autoCancel to false to make it non-dismissable
//   //       // channelDescription: 'TRYING TO PUSH UU',
//   //       sound: RawResourceAndroidNotificationSound(sound),
//   //       icon: 'launcher_icon',
//   //     ),
//   //   );
//   //   final nextNotificationTime = startTime.add(Duration(minutes: 10));
//   //   await flutterLocalNotificationsPlugin.periodicallyShow(
//   //     0, // Unique notification ID
//   //     title,
//   //     body,
//   //     nextNotificationTime,
//   //     notificationDetails,
//   //     androidAllowWhileIdle: true,
//   //     payload: 'notification_id_0', // Payload to identify notification
//   //   );
//   // }
//   // Future<void> scheduleAlarm(DateTime alarmTime, sound,index,loopInterval) async {
//   //   _alarmTime = alarmTime;

//   //   // Schedule the first notification
//   //   await scheduleNotification(index, 'it\'s Time', 'Ringing ⏰', alarmTime, sound);

//   //   // Schedule additional notifications with a 10-minute interval
//   //   for (int i = 1; i <= 100; i++) {
//   //     final additionalNotificationTime =
//   //         _alarmTime.add(Duration(minutes: loopInterval * i));

//   //     await scheduleNotification(
//   //         i, 'it\'s Time ⏰', 'Ringing ⏰', additionalNotificationTime, sound);

//   //     String audioPath = 'assets/sounds/${sound}.mp3';
//   //     print("audioPath $audioPath");
//   //     await playMusic(sound);
//   //   }
//   // }

//   // Future<void> playMusic(String audioPath) async {
//   //   // await audioPlayer.setSourceUrl(audioPath);
//   //   await audioPlayer.play(UrlSource(audioPath));
//   // }

//   // Future<void> scheduleNotification(
//   //   int id,
//   //   String title,
//   //   String body,
//   //   RepeatInterval interval,
//   //   sound,
//   // ) async {
//   //   await flutterLocalNotificationsPlugin.periodicallyShow(
//   //     id,
//   //     title,
//   //     body,
//   //     interval,
//   //     NotificationDetails(
//   //       android: AndroidNotificationDetails(
//   //         id.toString(),
//   //         "Channel Id $id",
//   //         channelShowBadge: true,
//   //         importance: Importance.high,
//   //         priority: Priority.high,
//   //         playSound: true,
//   //         ongoing: true, // Set as ongoing to make it persistent
//   //         autoCancel:
//   //             false, // Set autoCancel to false to make it non-dismissable
//   //         // channelDescription: 'TRYING TO PUSH UU',
//   //         sound: RawResourceAndroidNotificationSound(sound),
//   //         icon: 'launcher_icon',
//   //       ),
//   //     ),
//   //     androidAllowWhileIdle: true,
//   //     payload: 'notification_$id',
//   //   );
//   // }

//   Future<void> initializeTimeZone() async {
//     if (!timezoneInit) {
//       tzdata.initializeTimeZones();
//       final String timeZoneName = 'Africa/Casablanca'; // Morocco time zone
//       tz.setLocalLocation(tz.getLocation(timeZoneName));
//       timezoneInit = true;
//     }
//   }
// import 'dart:async';

import 'package:alarmloop/core/constant.dart';
import 'package:alarmloop/utils/style.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'notification_state.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class NotificationCubit extends Cubit<NotificationState> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final AwesomeNotifications notifications = AwesomeNotifications();
  bool _isInitialized = false;
  bool timezoneInit = false;

  NotificationCubit() : super(NotificationState());

  Future<void> initialize() async {
    if (!_isInitialized) {
      await notifications.initialize(
        'resource://drawable/launcher_icon', // Example icon path, replace with your own
        [
          NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic notifications',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white,
          ),
        ],
      );
      _isInitialized = true;
    }
    if (!timezoneInit) {
      tzdata.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation('Africa/Casablanca'));
      timezoneInit = true;
    }
  }

  Future<void> scheduleAlarm(
    DateTime alarmTime,
    String sound,
    int index,
    String loopInterval,
  ) async {
    await initialize();

    if (loopInterval == null ||
        !Constants.validLoopIntervals.contains(loopInterval)) {
      emit(state.copyWith(error: 'Invalid loop interval: $loopInterval'));
      return;
    }

    if (alarmTime.isBefore(tz.TZDateTime.now(tz.getLocation('Africa/Casablanca')))) {
      emit(state.copyWith(error: 'Alarm time cannot be in the past.'));
      return;
    }

    switch (loopInterval) {
      case '1 min':
        await scheduleMinuteLoopNotifications(alarmTime, sound, index);
        break;
      case '1 h':
        await scheduleHourlyLoopNotifications(alarmTime, sound, index);
        break;
      case '20 min':
        await scheduleTwentyMinuteLoopNotifications(alarmTime, sound, index);
        break;
      default:
        emit(state.copyWith(error: 'Unsupported loop interval: $loopInterval'));
        break;
    }
  }

  Future<void> scheduleHourlyLoopNotifications(
    DateTime startTime,
    String sound,
    int index,
  ) async {
    final notificationsScheduled = [];
    for (int i = 0; i < Constants.durationInMinutes / 20; i++) {
      final notificationTime = startTime.add(Duration(minutes: 20 * i));
      await scheduleNotification(
        index + i,
        'it\'s Time ⏰',
        'Ringing ⏰',
        notificationTime,
        sound,
      );
    }
  }

  Future<void> scheduleMinuteLoopNotifications(
    DateTime startTime,
    String sound,
    int index,
  ) async {
    final notificationsScheduled = [];
    for (int i = 0; i < Constants.durationInMinutes / 20; i++) {
      final notificationTime = startTime.add(Duration(minutes: 20 * i));
      await scheduleNotification(
        index + i,
        'it\'s Time ⏰',
        'Ringing ⏰',
        notificationTime,
        sound,
      );
    }
  }

  Future<void> scheduleTwentyMinuteLoopNotifications(
    DateTime startTime,
    String sound,
    int index,
  ) async {
    final notificationsScheduled = [];
    for (int i = 0; i < Constants.durationInMinutes / 20; i++) {
      final notificationTime = startTime.add(Duration(minutes: 20 * i));
      await scheduleNotification(
        index + i,
        'it\'s Time ⏰',
        'Ringing ⏰',
        notificationTime,
        sound,
      );
    }
  }

  Future<void> scheduleNotification(
    int id,
    String title,
    String body,
    DateTime notificationTime,
    String sound,
  ) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        autoDismissible: false,
        wakeUpScreen:true,
        id: id,
        channelKey: 'basic_channel', // Use the channelKey you have defined
        title: title,
        body: body,
        payload: {'alarmId': id.toString()},
      ),
      schedule: NotificationCalendar(
        weekday: notificationTime.weekday,
        hour: notificationTime.hour,
        minute: notificationTime.minute,
        second: notificationTime.second,
        allowWhileIdle: true,
        repeats: true, // Set to true if you want the notification to repeat
      ),
    );
  }
}
