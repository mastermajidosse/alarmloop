import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../alarm_cubit/alarm_edited_cubit.dart';
import '../../alarm_cubit/alarm_edited_state.dart';
import '../../alarm_cubit/alarm_updated_cubit.dart';
import '../../cubit/alarm_cubit.dart';
import '../../cubit/day_selection_cubit.dart';
import '../../cubit/day_selection_state.dart';
import '../../model/alarm_model.dart';
import '../../utils/style.dart';
import '../../widgets/custom_card.dart';

// ignore: must_be_immutable
class UpdatedEditAlarmForm extends StatelessWidget {
  String title = ''; // Use TextEditingController for better management
  bool isOn = true;
  bool isPm = false;
  List<bool> selectedDays = List.generate(7, (index) => false);

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
        title: const Text('Set Alarm'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<EditAlarmCubit, EditAlarmState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                !state.isAM
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
                      onTap: () async {
                        // Show time picker and set the selected time
                        TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        context
                            .read<EditAlarmCubit>()
                            .setAlarmTime(selectedTime!);
                      },
                      child: Row(
                        children: [
                          Text(
                            state.alarmTime.hour.toString() +
                                ':' +
                                state.alarmTime.minute.toString(),
                            style: TextStyle(
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            state.isAM ? 'AM' : 'PM',
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w500,
                            ),
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
                Image.asset('assets/images/clock.png'),
                // Dynamic days selection
                BlocBuilder<DaySelectionCubit, DaySelectionState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        7,
                        (index) => DayCard(dayIndex: index, alarmIndex: index),
                      ),
                    );
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(state.isAM
                              ? Icons.wb_sunny_outlined
                              : Icons.dark_mode_outlined),
                          onPressed: () {
                            // Toggle between AM and PM
                            context
                                .read<EditAlarmCubit>()
                                .setTimeOfDay(!state.isAM);
                          },
                        ),
                        Text(state.isAM ? 'AM' : 'PM'),
                      ],
                    ),

                    // Row(
                    //   children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     context.read<EditAlarmCubit>().setIsPm(false);
                    //   },
                    //   child: Text(
                    //     'AM',
                    //     style: TextStyle(
                    //       color: !state.isAM ? Colors.blue : Colors.black,
                    //       decoration:
                    //           !state.isAM ? TextDecoration.underline : null,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(width: 10),
                    // GestureDetector(
                    //   onTap: () {
                    //     context.read<EditAlarmCubit>().setIsPm(true);
                    //   },
                    //   child: Text(
                    //     'PM',
                    //     style: TextStyle(
                    //       color: state.isAM ? Colors.blue : Colors.black,
                    //       decoration:
                    //           state.isAM ? TextDecoration.underline : null,
                    //     ),
                    //   ),
                    // ),
                    //   ],
                    // ),
                    Row(
                      children: [
                        Text('Off'),
                        Switch(
                          value: state.isSwitched,
                          onChanged: (value) {
                            context.read<EditAlarmCubit>().setSwitch(value);
                          },
                        ),
                        Text('On'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Style.whiteClr),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(color: Style.blackClr),
                    ),
                    foregroundColor: MaterialStateProperty.all(Style.blackClr),
                  ),
                  onPressed: () {},
                  // onPressed: () => _saveAlarm(context),
                  child: Text('Set'),
                ),
              ],
            ),
          );
        },
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

  // void _saveAlarm(BuildContext context, UpdatedAlarmsState state) {
  //   // Check if there is at least one alarm in the list
  //   if (state.alarms.isNotEmpty) {
  //     // Assuming you want to use the properties of the first alarm in the list
  //     Alarm firstAlarm = state.alarms.first;

  //     // Parse the selectedDays string into a list of booleans
  //     List<bool> selectedDaysList = firstAlarm.selectedDays
  //         .split(' ')
  //         .map((day) => day.isNotEmpty)
  //         .toList();

  //     String selectedDaysString = '';
  //     for (int i = 0; i < selectedDaysList.length; i++) {
  //       if (selectedDaysList[i]) {
  //         selectedDaysString += getDayName(i).substring(0, 1) + ' ';
  //       }
  //     }

  //     Alarm newAlarm = Alarm(
  //       firstAlarm.title,
  //       selectedDaysString.trim(),
  //       firstAlarm.isOn,
  //       firstAlarm.isPm,
  //     );

  //     // Add the new alarm to the list and notify the cubit
  //     context.read<UpdatedAlarmsCubit>().addAlarm(newAlarm);
  //   }

  //   // Close the screen
  //   Navigator.pop(context);
  // }
}
