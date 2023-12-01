import 'package:alarmloop/model/alarm_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../cubit/alarm_cubit.dart';
import '../../cubit/day_selection_cubit.dart';
import '../../cubit/day_selection_state.dart';
import '../../cubit/notification_cubit.dart';
import '../../cubit/notification_state.dart';
import '../../cubit/set_alarm_time_cubit.dart';
import '../../cubit/set_alarm_time_state.dart';
import '../../utils/style.dart';
import '../../widgets/custom_card.dart';
import '../choose_alarm/choose_alarm_screen.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

// ignore: must_be_immutable
class UpdatedEditAlarmForm extends StatefulWidget {
  static String routeName = "/update-edited-screen";

  @override
  State<UpdatedEditAlarmForm> createState() => _UpdatedEditAlarmFormState();
}

class _UpdatedEditAlarmFormState extends State<UpdatedEditAlarmForm> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // late Stream<int> _countdownStream;

  // @override
  // void initState() {
  //   super.initState();
  //   _initializeNotifications();
  //   _initializeTimeZone();
  //   loadSoundAsset();
  // }

  // Future<void> _initializeTimeZone() async {
  //   tzdata.initializeTimeZones();
  //   final String timeZoneName = 'Africa/Casablanca'; // Morocco time zone
  //   tz.setLocalLocation(tz.getLocation(timeZoneName));
  // }

  // Future<void> _initializeNotifications() async {
  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');
  //   final InitializationSettings initializationSettings =
  //       InitializationSettings(
  //     android: initializationSettingsAndroid,
  //   );
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // }

// Future<void> _scheduleAlarm(DateTime alarmTime) async {
//   // Set the alarm time
//   _alarmTime = alarmTime;

//   // Calculate the duration until the first alarm time
//   // final durationUntilFirstAlarm = _alarmTime.difference(DateTime.now());

//   // Create a stream that emits a count of seconds until the first alarm time
//   // _countdownStream = Stream.periodic(Duration(seconds: 10), (count) {
//   //   var remainingSeconds = durationUntilFirstAlarm.inSeconds - count;
//   //   return remainingSeconds > 0 ? remainingSeconds : 0;
//   // }).take(durationUntilFirstAlarm.inSeconds);

//   // Schedule the first notification
//   await flutterLocalNotificationsPlugin.zonedSchedule(
//     0,
//     'Alarm',
//     'Wake up! It\'s time!',
//     tz.TZDateTime.from(alarmTime, tz.local),
//     NotificationDetails(
//       android: AndroidNotificationDetails(
//         'alarm_channel_id',
//         'Alarm Channel',
//         importance: Importance.high,
//         priority: Priority.high,
//         color: Style.greyColor,
//         playSound: true,
//         sound: const UriAndroidNotificationSound("assets/sounds/3.mp3"),
//         icon: 'launcher_icon',
//       ),
//     ),
//     androidAllowWhileIdle: true,
//     uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//   );

//   // Schedule the additional notifications with a 10-minute interval
//   for (int i = 1; i <= 2; i++) {
//     final nextAlarmTime = _alarmTime.add(Duration(minutes: 10 * i));
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       i,
//       'Alarm',
//       'Wake up! It\'s time!',
//       tz.TZDateTime.from(nextAlarmTime, tz.local),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'alarm_channel_id',
//           'Alarm Channel',
//           importance: Importance.high,
//           priority: Priority.high,
//           playSound: true,
//           sound: const UriAndroidNotificationSound("assets/sounds/3.mp3"),
//         ),
//       ),
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }

  // Future<void> _scheduleAlarm(DateTime alarmTime) async {
  //   // Set the alarm time
  //   _alarmTime = alarmTime;

  //   // Calculate the duration until the first alarm time
  //   final durationUntilFirstAlarm = _alarmTime.difference(DateTime.now());

  //   // Create a stream that emits a count of seconds until the first alarm time
  //   _countdownStream = Stream.periodic(Duration(seconds: 10), (count) {
  //     var remainingSeconds = durationUntilFirstAlarm.inSeconds - count;
  //     return remainingSeconds > 0 ? remainingSeconds : 0;
  //   }).take(durationUntilFirstAlarm.inSeconds);

  //   // Schedule the first notification
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     0,
  //     'Alarm',
  //     'Wake up! It\'s time!',
  //     tz.TZDateTime.from(alarmTime, tz.local),
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'alarm_channel_id',
  //         'Alarm Channel',
  //         importance: Importance.high,
  //         priority: Priority.high,
  //         color: Style.greyColor,
  //         // sound: RawResourceAndroidNotificationSound('alarm_sound'),
  //         playSound: true,
  //         sound: const UriAndroidNotificationSound("assets/sounds/3.mp3"),
  //         icon: '@mipmap/launcher_icon',
  //         largeIcon: DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
  //       ),
  //     ),
  //     androidAllowWhileIdle: true,
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //   );

  //   // Schedule the additional notifications with a 10-minute interval
  //   for (int i = 1; i <= 2; i++) {
  //     final nextAlarmTime = _alarmTime.add(Duration(minutes: 10 * i));
  //     await flutterLocalNotificationsPlugin.zonedSchedule(
  //       i,
  //       'Alarm',
  //       'Wake up! It\'s time!',
  //       tz.TZDateTime.from(nextAlarmTime, tz.local),
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           'alarm_channel_id',
  //           'Alarm Channel',
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           playSound: true,
  //         ),
  //       ),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //     );
  //   }
  // _countdownStream.listen((remainingSeconds) {
  // if (remainingSeconds == 1) {
  // final audioPlayer = AudioPlayer();
  // final alarmSound =
  //     'assets/sounds/alarm_sound.wav'; // Make sure 'alarm_sound.mp3' exists in your assets folder

  // audioPlayer.play(UrlSource(alarmSound));
  // }
  // });
  // }

  // Future<void> _scheduleAlarm(DateTime alarmTime) async {
  //   _alarmTime = alarmTime;

  // final durationUntilFirstAlarm = _alarmTime.difference(DateTime.now());

  // _countdownStream = Stream.periodic(Duration(seconds: 10), (count) {
  //   var remainingSeconds = durationUntilFirstAlarm.inSeconds - count;
  //   return remainingSeconds > 0 ? remainingSeconds : 0;
  // }).take(durationUntilFirstAlarm.inSeconds);

  @override
  Widget build(BuildContext context) {
    final notificationCubit = BlocProvider.of<NotificationCubit>(context);
    AlarmCubit bloc = BlocProvider.of<AlarmCubit>(context);
    AlarmModel alarm = bloc.state.alarms[bloc.state.indexSelectedAlarm];
    return BlocProvider.value(
      value: BlocProvider.of<AlarmCubit>(context),
      child: Scaffold(
        backgroundColor: Style.whiteClr,
        appBar: AppBar(
          leading: BackButton(
            color: Style.blackClr,
          ),
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Style.blackClr,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
          title: Text(
            'Set Alarm',
            style: Style.textStyleBtn(),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: BlocBuilder<AlarmCubit, AlarmState>(
          builder: (context, state) => SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                !alarm.isAm
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(3.14),
                        child: Icon(
                          Icons.dark_mode_outlined,
                          size: 30.0,
                          color: Colors.grey,
                        ),
                      )
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(3.14),
                        child: Icon(
                          Icons.wb_sunny,
                          size: 30.0,
                          color: Colors.orange,
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => bloc.selectAlarmTime(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: BlocBuilder<AlarmCubit, AlarmState>(
                              builder: (context, state) {
                                return Text(
                                  alarm.ringTime,
                                  style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            bloc.setIsAm() ? 'AM' : 'PM',
                            style: Style.textStyleBtn(),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ],
                ),
                Image.asset('assets/images/horloge.png'),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ChooseAlarmScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.music_note_rounded,
                        color: Colors.red,
                      ),
                      BlocBuilder<AlarmCubit, AlarmState>(
                          builder: (context, state) {
                        return Text(
                          alarm.sound.name,
                          style: TextStyle(fontSize: 20.sp),
                        );
                      }),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: const Divider(),
                ),
                // Dynamic days selection
                BlocBuilder<DaySelectionCubit, DaySelectionState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        7,
                        (index) => DayCard(
                          isHome: false,
                          dayIndex: index,
                          alarmIndex: alarm.id,
                          index: index,
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: const Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(alarm.isAm
                              ? Icons.wb_sunny_outlined
                              : Icons.dark_mode_outlined),
                          onPressed: () {
                            bloc.setIsAm()
                                ? bloc.turnOffSwitch(alarm.id)
                                : bloc.turnOnSwitch(alarm.id);
                          },
                        ),
                        Text(
                          bloc.setIsAm() ? 'AM' : 'PM',
                          style: Style.textStyleBtn(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Off',
                          style: Style.textStyleBtn(),
                        ),
                        Switch(
                          value: alarm.isEnabled,
                          onChanged: (value) {
                            if (value == true) {
                              bloc.turnOnCheckBox(alarm.id);
                            } else {
                              bloc.turnOffCheckBox(alarm.id);
                            }
                            print("isEnabled$value");
                          },
                          activeTrackColor: Style.blackClr,
                          activeColor: Style.greenClr,
                          inactiveThumbColor: Style.blackClr,
                          inactiveTrackColor: Style.greyColor,
                        ),
                        Text(
                          'On',
                          style: Style.textStyleBtn(),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                // TextButton(
                //   style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.all(Style.whiteClr),
                //     textStyle: MaterialStateProperty.all(
                //       TextStyle(color: Style.blackClr),
                //     ),
                //     foregroundColor: MaterialStateProperty.all(Style.blackClr),
                //   ),
                //   onPressed: () async {
                //     DateTime ringTime = DateFormat.Hm().parse(alarm.ringTime);
                //     int hours = ringTime.hour;
                //     int minutes = ringTime.minute;

                //     final moroccoTimeZone = tz.getLocation('Africa/Casablanca');
                //     final now = tz.TZDateTime.now(moroccoTimeZone);
                //     final alarmTime = tz.TZDateTime(moroccoTimeZone, now.year,
                //         now.month, now.day, hours, minutes);
                //     print("Local Time: ${alarmTime.toLocal()}");
                //     print("Local Time: $alarmTime");

                //     bloc.saveAlarm(context);
                //     if (alarm.isEnabled) {
                //       await _scheduleAlarm(alarmTime);
                //     }
                //   },
                //   // onPressed: () => _saveAlarm(context),
                //   child: Text(
                //     'SET',
                //     style: Style.textStyleBtn(),
                //   ),
                // ),
                BlocBuilder<SetAlarmTimeCubit, SetAlarmTimeState>(
                  builder: (context, notificationState) => TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Style.whiteClr),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(color: Style.blackClr),
                      ),
                      foregroundColor:
                          MaterialStateProperty.all(Style.blackClr),
                    ),
                    onPressed: () async {
                      if (notificationState is NotificationInitialState) {
                        await notificationCubit.initializeNotifications();
                        print('Initialized notifications');
                      }

                      if (notificationState is TimeZoneInitialState) {
                        await notificationCubit.initializeTimeZone();
                        print('Initialized timezone');
                      }

                      DateTime ringTime = DateFormat.Hm().parse(alarm.ringTime);
                      int hours = ringTime.hour;
                      int minutes = ringTime.minute;

                      final moroccoTimeZone =
                          tz.getLocation('Africa/Casablanca');
                      final now = tz.TZDateTime.now(moroccoTimeZone);
                      final alarmTime = tz.TZDateTime(moroccoTimeZone, now.year,now.month, now.day, hours, minutes);
                      print("Local Time: ${alarmTime.toLocal()}");
                      print("Local Time: $alarmTime");
                      bloc.saveAlarm(context);
                      if (alarm.isEnabled) {
                        await notificationCubit.scheduleAlarm(alarmTime);
                      }
                    },

                    // onPressed: () => _saveAlarm(context),
                    child: Text(
                      'SET',
                      style: Style.textStyleBtn(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getDayName(int index) {
    switch (index) {
      case 0:
        return 'Monday';
      case 1:
        return 'Tuesday';
      case 2:
        return 'Wednesday';
      case 3:
        return 'Thursday';
      case 4:
        return 'Friday';
      case 5:
        return 'Saturday';
      case 6:
        return 'Sunday';
      default:
        return '';
    }
  }
}
