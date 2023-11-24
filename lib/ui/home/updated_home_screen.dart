import 'package:alarmloop/utils/style.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../alarm_cubit/update/update_alarm_cubit.dart';
import '../../core/core.dart';
import '../../core/notifier.dart';
import '../../cubit/alarm_cubit.dart';
import '../../cubit/day_selection_cubit.dart';
import '../../cubit/day_selection_state.dart';
import '../../model/alarm_model.dart';
import '../../widgets/custom_card.dart';
import 'package:timezone/timezone.dart' as tz;

class UpdatedHomeScreen extends StatefulWidget {
  static String routeName = "/update-home";
  UpdatedHomeScreen({Key? key}) : super(key: key);

  @override
  State<UpdatedHomeScreen> createState() => _UpdatedHomeScreenState();
}

class _UpdatedHomeScreenState extends State<UpdatedHomeScreen> {
  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);

    super.initState();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _initializeLocalNotifications();
  // }

  // Future<void> _initializeLocalNotifications() async {
  //   var initializationSettingsAndroid =
  //       new AndroidInitializationSettings('@mipmap/ic_launcher');
  //   final InitializationSettings initializationSettings =
  //       InitializationSettings(
  //     android: initializationSettingsAndroid,
  //   );

  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //       onSelectNotification: _onSelectNotification);
  // }

  // Future<void> _onSelectNotification(String? payload) async {
  //   // Handle notification click here
  //   print("Notification Clicked! Payload: $payload");
  //   // Add your logic to play sound or show a dialog here

  //   // Example: Play a sound
  //   final player = AudioPlayer();
  //   player.play(UrlSource('assets/sounds/2.mp3'));
  // }

  // Future<void> scheduleAlarm(int id, String title, String body, int selectedDay,
  //     int hour, int minute) async {
  //   final AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'alarmId',
  //     'alarmKeyChannel',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     playSound: true,
  //     sound: RawResourceAndroidNotificationSound('assets/sounds/2.mp3'),
  //   );
  //   final NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);

  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     id,
  //     title,
  //     body,
  //     _nextInstanceOfTime(selectedDay, hour, minute),
  //     platformChannelSpecifics,
  //     androidAllowWhileIdle: true,
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //     payload: 'custom payload',
  //   );

  //   // Simulate the user selecting the notification immediately
  //   await _onSelectNotification('custom payload');
  // }

  // tz.TZDateTime _nextInstanceOfTime(int selectedDay, int hour, int minute) {
  //   // Get the current time in the user's local timezone
  //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

  //   // Calculate the difference between the selected day and the current day
  //   int daysUntilAlarm = (selectedDay - now.weekday + 7) % 7;

  //   // Calculate the time of the next alarm occurrence
  //   tz.TZDateTime scheduledDate = tz.TZDateTime(
  //     tz.local,
  //     now.year,
  //     now.month,
  //     now.day + daysUntilAlarm,
  //     hour,
  //     minute,
  //   );

  //   // If the calculated time is in the past or on the same day but the time has passed, move it to the next week
  //   if (scheduledDate.isBefore(now) ||
  //       (daysUntilAlarm == 0 &&
  //           scheduledDate.isAtSameMomentAs(now) &&
  //           scheduledDate.isBefore(now))) {
  //     scheduledDate = scheduledDate.add(Duration(days: 7));
  //   }
  //   print("scheduledDate:::>$scheduledDate");
  //   return scheduledDate;
  // }

  @override
  Widget build(BuildContext context) {
    AlarmCubit bloc = BlocProvider.of<AlarmCubit>(context);

    return BlocProvider.value(
      value: BlocProvider.of<AlarmCubit>(context)..loadAlarms(),
      child: Scaffold(
        backgroundColor: Style.whiteClr,
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Style.blackClr,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
          title: Text(
            'Alarm',
            style: Style.textStyleBtn(),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  AwesomeNotifications().createNotification(
                      content: NotificationContent(
                    badge: 1,
                    id: 10,
                    channelKey: 'basic_channel',
                    actionType: ActionType.Default,
                    title: 'Ringing Alarm',
                    body: 'Time of ringing the alarm',
                  ));
                  // scheduleAlarm(1, 'title', 'body', 1, 9, 8);
                },
                icon: Icon(Icons.alarm_rounded, color: Style.blackClr))
          ],
        ),
        body: BlocBuilder<AlarmCubit, AlarmState>(
          builder: (context, state) {
            return state.alarms.isEmpty
                ? buildEmptyState(context)
                : ListView.builder(
                    itemCount: state.alarms.length,
                    itemBuilder: (context, index) {
                      AlarmModel alarm = state.alarms[index];

                      return InkWell(
                        onTap: () async {
                          bloc.editAlarm(context, index);
                        },
                        onLongPress: () {
                          // Show a confirmation dialog when the card is long-pressed
                          showDeleteConfirmationDialog(
                              context, alarm, alarm.id);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(6.0),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            alarm.isAm
                                                ? Icons.wb_sunny_outlined
                                                : Icons.dark_mode_outlined,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            alarm.ringTime,
                                            style: Style.clockStyle(),
                                          ),
                                        ],
                                      ),
                                      Switch.adaptive(
                                        value: alarm.isEnabled,
                                        onChanged: (value) {
                                          print(
                                              'Alarm ${alarm.title} is ${value ? 'on' : 'off'}');
                                        },
                                        activeTrackColor: Style.blackClr,
                                        activeColor: Style.greenClr,
                                        inactiveThumbColor: Style.blackClr,
                                        inactiveTrackColor: Style.greyColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  BlocBuilder<DaySelectionCubit,
                                      DaySelectionState>(
                                    builder: (context, daySelectionState) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: List.generate(
                                          7,
                                          (index) => GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<DaySelectionCubit>()
                                                  .toggleDay(index);
                                            },
                                            child: DayCard(
                                              index: index,
                                              dayIndex: index,
                                              alarmIndex: index,
                                              isHome: true,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Style.greyColor,
          onPressed: () => bloc.addNewAlarm(context),
          child: Icon(Icons.alarm_add),
        ),
      ),
    );
  }

  Widget buildDaysRow(String selectedDays) {
    List<String> allDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Row(
      children: allDays.map((day) {
        bool isSelected = selectedDays.contains(day);
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0),
          margin: EdgeInsets.only(right: 4.0),
          child: Text(
            day,
            style: isSelected
                ? Style.isSelectedDayStyle()
                : Style.isNotSelectedDayStyle(),
          ),
        );
      }).toList(),
    );
  }
}
