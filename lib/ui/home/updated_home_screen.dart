import 'package:alarmloop/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../alarm_cubit/alarm_updated_cubit.dart';
import '../../alarm_cubit/alarm_updated_state.dart';
import '../../alarm_cubit/update/update_alarm_cubit.dart';
import '../../core/core.dart';
import '../../cubit/day_selection_cubit.dart';
import '../../cubit/day_selection_state.dart';
import '../../model/alarm.dart';
import '../../model/args_model.dart';
import '../../widgets/cards/alarm_card.dart';
import '../../widgets/custom_card.dart';
import '../add_alarm/add_new_alarm.dart';
import '../edit/updated_edited_screen.dart';

class UpdatedHomeScreen extends StatefulWidget {
  static String routeName = "/update-home";
  const UpdatedHomeScreen({Key? key}) : super(key: key);

  @override
  State<UpdatedHomeScreen> createState() => _UpdatedHomeScreenState();
}

class _UpdatedHomeScreenState extends State<UpdatedHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: BlocBuilder<UpdatedAlarmsCubit, UpdatedAlarmsState>(
        builder: (context, state) {
          if (state.alarms.isEmpty) {
            context.read<UpdatedAlarmsCubit>().loadAlarms();
          }
          return state.alarms.isEmpty
              ? buildEmptyState(context)
              : ListView.builder(
                  itemCount: state.alarms.length,
                  itemBuilder: (context, index) {
                    final alarm = state.alarms[index];
                    return InkWell(
                      onTap: () async {
                        final updatedAlarm = await Navigator.pushNamed(
                          context,
                          UpdatedEditAlarmForm.routeName,
                          arguments:
                              AlarmEditArguments(alarm: alarm, index: index),
                        );
                        print("udapted::::::::::::>$updatedAlarm");
                        if (updatedAlarm != null) {
                          context
                              .read<AlarmsCubitUpdated>()
                              .updateAlarm(updatedAlarm as Alarm);
                        }
                      },
                      onLongPress: () {
                        // Show a confirmation dialog when the card is long-pressed
                        showDeleteConfirmationDialog(context, alarm);
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
                                          alarm.isAM
                                              ? Icons.wb_sunny_outlined
                                              : Icons.dark_mode_outlined,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          alarm.hour.toString() +
                                              ":" +
                                              alarm.minute.toString(),
                                          style: Style.clockStyle(),
                                        ),
                                      ],
                                    ),
                                    Switch.adaptive(
                                      value: alarm.isSwitched,
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
                                            index:index,
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
        onPressed: () => Navigator.pushNamed(
          context,
          AddNewAlarmScreen.routeName,
        ),
        child: Icon(Icons.alarm_add),
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
