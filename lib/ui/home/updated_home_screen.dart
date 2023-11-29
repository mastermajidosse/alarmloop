import 'package:alarmloop/utils/style.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                // AwesomeNotifications().createNotification(
                //     content: NotificationContent(
                //   badge: 1,
                //   id: 10,
                //   channelKey: 'basic_channel',
                //   actionType: ActionType.Default,
                //   title: 'Ringing Alarm',
                //   body: 'Time of ringing the alarm',
                // ));
                // scheduleAlarm(1, 'title', 'body', 1, 9, 8);
              },
              icon: Icon(Icons.alarm_rounded, color: Style.blackClr),
            ),
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
