// import 'package:audioplayers/audioplayers.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';

// class TestAlarm extends StatefulWidget {
//   @override
//   _TestAlarmState createState() => _TestAlarmState();
// }

// class _TestAlarmState extends State<TestAlarm> {
//   int _notificationId = 0;
//   AudioPlayer _audioPlayer = AudioPlayer();

//   @override
//   void initState() {
//     super.initState();
//     AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//           channelKey: 'basic_channel',
//           channelName: 'Basic notifications',
//           channelDescription: 'Notification channel for basic notifications',
//           defaultColor: Colors.teal,
//           ledColor: Colors.teal,
//           playSound: false, // Set to false to prevent the default notification sound
//           enableLights: true,
//           enableVibration: true,
//         ),
//       ],
//     );
//   }
// //
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Alarm App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 _scheduleAlarm();
//               },
//               child: Text('Set Alarm'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _cancelAlarm();
//               },
//               child: Text('Cancel Alarm'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _scheduleAlarm() async {
//     final id = await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: _notificationId,
//         channelKey: 'basic_channel',
//         title: 'Alarm',
//         body: 'Wake up! It\'s time!',
//       ),
//       actionButtons: [
//         NotificationActionButton(
//           key: 'SNOOZE_BUTTON',
//           label: 'Snooze',
//           autoDismissible : true,
//           actionType : ActionType.Default,
//           // payload: {'notificationId': _notificationId, 'action': 'SNOOZE'},
//         ),
//         NotificationActionButton(
//           key: 'DISMISS_BUTTON',
//           label: 'Dismiss',
//           autoDismissible : true,
//           actionType: ActionType.Default,
//           // payload: {'notificationId': _notificationId, 'action': 'DISMISS'},
//         ),
//       ],
//     );

//     print('Alarm scheduled with ID: $id');
//     _playAlarmSound();
//     _notificationId++;
//   }

//   void _cancelAlarm() async {
//     await AwesomeNotifications().cancel(_notificationId - 1);
//     print('Alarm canceled');
//     _stopAlarmSound();
//   }

//   void _playAlarmSound() async {
//     await _audioPlayer.play(UrlSource('assets/sounds/2.mp3',));
//   }

//   void _stopAlarmSound() {
//     _audioPlayer.stop();
//   }
// }

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:audio_session/audio_session.dart';

// class TestAlarm extends StatefulWidget {
//   @override
//   _TestAlarmState createState() => _TestAlarmState();
// }

// class _TestAlarmState extends State<TestAlarm> {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   @override
//   void initState() {
//     super.initState();
//     initNotifications();
//   }

//   Future<void> initNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/launcher_icon');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//     );
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future<void> showNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'alarm_channel_id',
//       'Alarm Channel',
//       // 'Channel for alarm audio',
//       importance: Importance.high,
//       priority: Priority.high,
//       // sound: RawResourceAndroidNotificationSound(
//       //     'alarm_sound'), // Use the resource ID
//       largeIcon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'), // Use the resource ID/ Use the resource ID
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     flutterLocalNotificationsPlugin.show(
//       0,
//       'Alarm',
//       'Wake up! It\'s time!',
//       platformChannelSpecifics,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Alarm App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 showNotification();
//               },
//               child: Text('Show Alarm Notification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:timezone/timezone.dart' as tz;

// class AlarmScreen extends StatefulWidget {
//   @override
//   _AlarmScreenState createState() => _AlarmScreenState();
// }

// class _AlarmScreenState extends State<AlarmScreen> {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
//   @override
//   void initState() {
//     super.initState();
//     _initializeNotifications();
//   }

//   Future<void> _initializeNotifications() async {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future<void> _scheduleAlarm(DateTime alarmTime) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'alarm_channel_id',
//       'Alarm Channel',
//       importance: Importance.high,
//       priority: Priority.high,
//       sound: RawResourceAndroidNotificationSound('alarm_sound'), // Replace with your sound file
//     );
//     const IOSNotificationDetails iOSPlatformChannelSpecifics =
//         IOSNotificationDetails();
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );

//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       'Alarm',
//       'Wake up! It\'s time!',
//       tz.TZDateTime.from(alarmTime, tz.local),
//       platformChannelSpecifics,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }

//   Future<void> _showNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'alarm_channel_id',
//       'Alarm Channel',
//       importance: Importance.high,
//       priority: Priority.high,
//       sound: RawResourceAndroidNotificationSound('alarm_sound'), // Replace with your sound file
//     );
//     const IOSNotificationDetails iOSPlatformChannelSpecifics =
//         IOSNotificationDetails();
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Alarm',
//       'Wake up! It\'s time!',
//       platformChannelSpecifics,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Alarm App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 // await _showNotification();
//                 // await _startAlarm();

//                 final alarmTime = DateTime.now().add(Duration(seconds: 10));
//                 await _scheduleAlarm(alarmTime);
//               },
//               // child: Text('Set Alarm'),
//               child: Text('Set Alarm in 10 seconds'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _startAlarm() async {
//     final player = AudioPlayer();
//     await player
//         .setAsset('assets/sounds/3.mp3'); // Replace with your alarm sound file
//     await player.setLoopMode(LoopMode.off);
//     player.play();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }

//:::::::::::::::::::::::::::::::::::::::::

import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late StreamController<int> _countdownController;
  late Stream<int> _countdownStream;
  late DateTime _alarmTime;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _countdownController = StreamController<int>();
    _countdownStream = _countdownController.stream.asBroadcastStream();
  }

  Future<void> _initializeNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _scheduleAlarm(DateTime alarmTime) async {
    // Set the alarm time
    _alarmTime = alarmTime;

    // Calculate the duration until the alarm time
    final durationUntilAlarm = _alarmTime.difference(DateTime.now());

    // Create a stream that emits a count of seconds until the alarm time
    _countdownStream = Stream.periodic(Duration(seconds: 1), (count) {
      var remainingSeconds = durationUntilAlarm.inSeconds - count;
      return remainingSeconds > 0 ? remainingSeconds : 0;
    }).take(durationUntilAlarm.inSeconds);

    // Schedule the notification
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'alarm_channel_id',
      'Alarm Channel',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Alarm',
      'Wake up! It\'s time!',
      tz.TZDateTime.from(alarmTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    // Play the alarm sound when the alarm time arrives
    // _countdownStream.listen((remainingSeconds) {
    // if (remainingSeconds == 1) {
    // final audioPlayer = AudioPlayer();
    // final alarmSound =
    //     'alarm_sound.mp3'; // Make sure 'alarm_sound.mp3' exists in your assets folder

    // audioPlayer.play(UrlSource(alarmSound));
    // }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Alarm App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final alarmTime = DateTime.now().add(Duration(seconds: 10));
                await _scheduleAlarm(alarmTime);
                final audioPlayer = AudioPlayer();
                final alarmSound ='sounds/2.mp3'; // Make sure 'alarm_sound.mp3' exists in your assets folder

                audioPlayer.play(UrlSource(alarmSound));
              },
              child: Text('Set Alarm in 10 seconds'),
            ),
            SizedBox(height: 20),
            StreamBuilder<int>(
              stream: _countdownStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('Time remaining: ${snapshot.data} seconds');
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
