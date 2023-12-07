import 'dart:isolate';

import 'package:alarmloop/cubit/notification_cubit.dart';
import 'package:alarmloop/utils/style.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/core.dart';
import '../../core/notifier.dart';
import '../../cubit/alarm_cubit.dart';
import '../../model/alarm_model.dart';
import '../../widgets/button/bottom_add_bottom.dart';
import '../../widgets/custom_card.dart';
import 'package:timezone/timezone.dart' as tz;

class UpdatedHomeScreen extends StatefulWidget {
  static String routeName = "/update-home";
  UpdatedHomeScreen({Key? key}) : super(key: key);

  @override
  State<UpdatedHomeScreen> createState() => _UpdatedHomeScreenState();
}

class _UpdatedHomeScreenState extends State<UpdatedHomeScreen> {
  @override
  Widget build(BuildContext context) {
    AlarmCubit bloc = BlocProvider.of<AlarmCubit>(context);
    // int selectedAlarmIndex = bloc.state.indexSelectedAlarm ?? 0;
    // AlarmModel alarm = bloc.state.alarms[selectedAlarmIndex];
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
        ),
        body: BlocBuilder<AlarmCubit, AlarmState>(
          builder: (context, state) {
            return state.alarms.isEmpty
                ? buildEmptyState(context)
                : ListView.separated(
                    itemCount: state.alarms.length,
                    itemBuilder: (context, index) {
                      AlarmModel alarm = state.alarms[index];

                      return InkWell(
                        onTap: () async {
                          bloc.editAlarm(context, index);
                        },
                        // onLongPress: () {
                        //   // Show a confirmation dialog when the card is long-pressed
                        //   showDeleteConfirmationDialog(
                        //       context, alarm, alarm.id);
                        // },
                        child: Dismissible(
                          key: Key(alarm.id.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            await showDeleteConfirmationDialog(
                                context, alarm, alarm.id);
                          },
                          onDismissed: (direction) {},
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
                                            print("value");
                                            if (value == true) {
                                              bloc.turnOnCheckBox(alarm.id);
                                            } else {
                                              bloc.turnOffCheckBox(alarm.id, context);
                                              BlocProvider.of<NotificationCubit>(context).cancelNotifications(alarm.id);
                                            }
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Style.greyColor,
          onPressed: () {
            bloc.addNewAlarm(context);
            // printHello();
          },
          child: Icon(Icons.add_circle),
        ),
      ),
    );
  }
}
