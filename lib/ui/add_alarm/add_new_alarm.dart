// import 'package:alarmloop/ui/home/updated_home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../alarm_cubit/alarm_edited_cubit.dart';
// import '../../alarm_cubit/alarm_edited_state.dart';
// import '../../alarm_cubit/alarm_updated_cubit.dart';
// import '../../cubit/day_selection_cubit.dart';
// import '../../cubit/day_selection_state.dart';
// import '../../model/alarm.dart';
// import '../../utils/style.dart';
// import '../../widgets/custom_card.dart';

// // ignore: must_be_immutable
// class AddNewAlarmScreen extends StatelessWidget {
//   static String routeName = "/add-newAlarm-screen";

//   String title = ''; // Use TextEditingController for better management
//   bool isOn = true;
//   bool isPm = false;
//   List<bool> selectedDays = List.generate(7, (index) => false);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Style.whiteClr,
//       appBar: AppBar(
//         leading: BackButton(
//           color: Style.blackClr,
//         ),
//         backgroundColor: Colors.white,
//         titleTextStyle: TextStyle(
//           color: Style.blackClr,
//           fontSize: 20.sp,
//           fontWeight: FontWeight.w500,
//         ),
//         title: Text(
//           'Set Alarm',
//           style: Style.textStyleBtn(),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: BlocBuilder<EditAlarmCubit, EditAlarmState>(
//         builder: (context, state) {
//           return SingleChildScrollView(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 !state.isAM
//                     ? Transform(
//                         alignment: Alignment.center,
//                         transform: Matrix4.rotationY(3.14),
//                         child: Icon(
//                           Icons.dark_mode_outlined,
//                           size: 30.0,
//                           color: Colors.grey,
//                         ),
//                       )
//                     : Transform(
//                         alignment: Alignment.center,
//                         transform: Matrix4.rotationY(3.14),
//                         child: Icon(
//                           Icons.wb_sunny,
//                           size: 30.0,
//                           color: Colors.orange,
//                         ),
//                       ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () async {
//                         // Show time picker and set the selected time
//                         TimeOfDay? selectedTime = await showTimePicker(
//                           context: context,
//                           initialTime: TimeOfDay.now(),
//                         );
//                         context
//                             .read<EditAlarmCubit>()
//                             .setAlarmTime(selectedTime!);
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                               state.alarmTime.hour.toString() +
//                                   ':' +
//                                   state.alarmTime.minute.toString(),
//                               style: Style.clockStyle()),
//                           SizedBox(width: 10),
//                           Text(
//                             state.isAM ? 'AM' : 'PM',
//                             style: Style.textStyleBtn(),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//                 Image.asset('assets/images/horloge.png'),
//                 // Dynamic days selection
//                 BlocBuilder<DaySelectionCubit, DaySelectionState>(
//                   builder: (context, state) {
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: List.generate(
//                         7,
//                         (index) => DayCard(dayIndex: index, alarmIndex: index,isHome: false,index: index,),
//                       ),
//                     );
//                   },
//                 ),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: Icon(state.isAM
//                               ? Icons.wb_sunny_outlined
//                               : Icons.dark_mode_outlined),
//                           onPressed: () {
//                             // Toggle between AM and PM
//                             context
//                                 .read<EditAlarmCubit>()
//                                 .setTimeOfDay(!state.isAM);
//                           },
//                         ),
//                         Text(
//                           state.isAM ? 'AM' : 'PM',
//                           style: Style.textStyleBtn(),
//                         ),
//                       ],
//                     ),

//                     // Row(
//                     //   children: [
//                     // GestureDetector(
//                     //   onTap: () {
//                     //     context.read<EditAlarmCubit>().setIsPm(false);
//                     //   },
//                     //   child: Text(
//                     //     'AM',
//                     //     style: TextStyle(
//                     //       color: !state.isAM ? Colors.blue : Colors.black,
//                     //       decoration:
//                     //           !state.isAM ? TextDecoration.underline : null,
//                     //     ),
//                     //   ),
//                     // ),
//                     // SizedBox(width: 10),
//                     // GestureDetector(
//                     //   onTap: () {
//                     //     context.read<EditAlarmCubit>().setIsPm(true);
//                     //   },
//                     //   child: Text(
//                     //     'PM',
//                     //     style: TextStyle(
//                     //       color: state.isAM ? Colors.blue : Colors.black,
//                     //       decoration:
//                     //           state.isAM ? TextDecoration.underline : null,
//                     //     ),
//                     //   ),
//                     // ),
//                     //   ],
//                     // ),
//                     Row(
//                       children: [
//                         Text(
//                           'Off',
//                           style: Style.textStyleBtn(),
//                         ),
//                         Switch(
//                           value: state.isSwitched,
//                           onChanged: (value) {
//                             context.read<EditAlarmCubit>().setSwitch(value);
//                           },
//                           activeTrackColor: Style.blackClr,
//                           activeColor: Style.greenClr,
//                           inactiveThumbColor: Style.blackClr,
//                           inactiveTrackColor: Style.greyColor,
//                         ),
//                         Text(
//                           'On',
//                           style: Style.textStyleBtn(),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 32.0),
//                 TextButton(
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(Style.whiteClr),
//                     textStyle: MaterialStateProperty.all(
//                       TextStyle(color: Style.blackClr),
//                     ),
//                     foregroundColor: MaterialStateProperty.all(Style.blackClr),
//                   ),
//                   onPressed: () async {
//                     // Create a new alarm
//                     Alarm newAlarm = Alarm(
//                        state.id,
//                       state.selectedDays,
//                       'Alarm',
//                        state.isSwitched,
//                        state.isAM,
//                       state.alarmTime.hour,
//                        state.alarmTime.minute,
//                        state.alarmTime.period.toString(),
//                     );
//                       print('Selected Days in HomeScreen: ${state.selectedDays}');
//                     // Add the new alarm to the list and save it to SharedPreferences
//                     await context.read<UpdatedAlarmsCubit>().addAlarm(newAlarm);
//                     Navigator.pop(context);
//                   },
//                   // onPressed: () => _saveAlarm(context),
//                   child: Text(
//                     'SET',
//                     style: Style.textStyleBtn(),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   String getDayName(int index) {
//     switch (index) {
//       case 0:
//         return 'Monday';
//       case 1:
//         return 'Tuesday';
//       case 2:
//         return 'Wednesday';
//       case 3:
//         return 'Thursday';
//       case 4:
//         return 'Friday';
//       case 5:
//         return 'Saturday';
//       case 6:
//         return 'Sunday';
//       default:
//         return '';
//     }
//   }

//   // void _saveAlarm(BuildContext context, UpdatedAlarmsState state) {
//   //   // Check if there is at least one alarm in the list
//   //   if (state.alarms.isNotEmpty) {
//   //     // Assuming you want to use the properties of the first alarm in the list
//   //     Alarm firstAlarm = state.alarms.first;

//   //     // Parse the selectedDays string into a list of booleans
//   //     List<bool> selectedDaysList = firstAlarm.selectedDays
//   //         .split(' ')
//   //         .map((day) => day.isNotEmpty)
//   //         .toList();

//   //     String selectedDaysString = '';
//   //     for (int i = 0; i < selectedDaysList.length; i++) {
//   //       if (selectedDaysList[i]) {
//   //         selectedDaysString += getDayName(i).substring(0, 1) + ' ';
//   //       }
//   //     }

//   //     Alarm newAlarm = Alarm(
//   //       firstAlarm.title,
//   //       selectedDaysString.trim(),
//   //       firstAlarm.isOn,
//   //       firstAlarm.isPm,
//   //     );

//   //     // Add the new alarm to the list and notify the cubit
//   //     context.read<UpdatedAlarmsCubit>().addAlarm(newAlarm);
//   //   }

//   //   // Close the screen
//   //   Navigator.pop(context);
//   // }

//   void _setAlarm(BuildContext context) {
//     // Get the current state using the EditAlarmCubit
//     EditAlarmState state = context.read<EditAlarmCubit>().state;

//     // Check if the alarm is set to be turned on
//     if (state.isSwitched) {
//       // Construct the full DateTime object based on the user's selections
//       DateTime now = DateTime.now();
//       DateTime alarmDateTime = DateTime(
//         now.year,
//         now.month,
//         now.day,
//         state.alarmTime.hour,
//         state.alarmTime.minute,
//       );

//       // Add the selected days to the alarm
//       List<bool> selectedDaysList =
//           state.selectedDays.split(' ').map((day) => day.isNotEmpty).toList();

//       // Loop through each selected day and schedule an alarm
//       for (int i = 0; i < selectedDaysList.length; i++) {
//         if (selectedDaysList[i]) {
//           DateTime scheduledTime =
//               alarmDateTime.add(Duration(days: (i - now.weekday + 7) % 7));

//           // TODO: Implement the logic to schedule the alarm using the scheduledTime
//           print('Alarm scheduled for: $scheduledTime');
//         }
//       }

//       // Notify the user that the alarm is set
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Alarm set for ${state.alarmTime.format(context)}'),
//         ),
//       );

//       // Toggle the day selection

//       // Log the selected days
//       List<bool> selectedDays =
//           context.read<DaySelectionCubit>().state.selectedDays;
//       print('Selected Days: $selectedDays');
//       // Close the screen
//       Navigator.pop(context);
//     } else {
//       // Notify the user that the alarm is turned off
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Alarm is turned off. Enable it before setting.'),
//         ),
//       );
//     }
//   }
// }