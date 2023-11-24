import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../model/alarm.dart';
import 'alarm_edited_state.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EditAlarmCubit extends Cubit<EditAlarmState> {
  EditAlarmCubit({Alarm? initialAlarm})
      : super(initialAlarm != null
            ? EditAlarmState.fromAlarm(initialAlarm)
            : EditAlarmState(
                id: 0,
                isAM: true,
                alarmTime: TimeOfDay.now(),
                selectedDays: '',
                isSwitched: false,
              ));

  /*
    Start Save Method
 */
  // void save(BuildContext context, int index) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? alarmStrings = prefs.getStringList('alarms');

  //   List<Alarm> _alarms = alarmStrings != null
  //       ? alarmStrings.map((json) => Alarm.fromJson(jsonDecode(json))).toList()
  //       : [];

  //   if (index != -1 && index < _alarms.length && index != null) {
  //     Alarm existingAlarm = _alarms[index];
  //     _alarms[index] = Alarm(
  //       id: existingAlarm.id,
  //       title: existingAlarm.title,
  //       selectedDays: state.selectedDays,
  //       isSwitched: state.isSwitched,
  //       isAM: state.isAM,
  //       hour: state.alarmTime.hour,
  //       minute: state.alarmTime.minute,
  //       period: state.alarmTime.period.index == 0 ? "AM" : "PM",
  //     );
  //   } else {
  //     // Handle the case where the index is not valid (optional)
  //   }

  //   // Save the updated list to SharedPreferences
  //   List<String> updatedAlarmStrings =
  //       _alarms.map((alarm) => jsonEncode(alarm.toJson())).toList();
  //   await prefs.setStringList('alarms', updatedAlarmStrings);

  //   // ... existing code ...
  // }

  /*
   End Save Method
  */

  // void initializeWithExistingAlarm(Alarm existingAlarm) {
  //   emit(EditAlarmState(
  //     id: existingAlarm.id,
  //     isAM: existingAlarm.isAM,
  //     alarmTime: TimeOfDay(
  //       hour: existingAlarm.hour,
  //       minute: existingAlarm.minute,
  //     ),
  //     isSwitched: existingAlarm.isSwitched,
  //     selectedDays: existingAlarm.selectedDays,
  //   ));
  // }

  void setTimeOfDay(bool isAM) {
    emit(state.copyWith(isAM: isAM));
  }

  void setAlarmTime(TimeOfDay alarmTime) {
    emit(state.copyWith(alarmTime: alarmTime));
  }

  void setDays(String selectedDays) {
    emit(state.copyWith(selectedDays: selectedDays));
  }

  void setSwitch(bool isSwitched) {
    emit(state.copyWith(isSwitched: isSwitched));
  }

  // Other methods...

  void setIsPm(bool isPm) {
    emit(state.copyWith(isAM: isPm));
  }

  // void save2(BuildContext context) async {
  //   // Create a new edited alarm
  //   Alarm editedAlarm = Alarm(
  //     id: 1,
  //     title: 'Edited Alarm', // You may use the actual title logic
  //     selectedDays: state.selectedDays,
  //     isSwitched: state.isSwitched,
  //     isAM: state.isAM,
  //     hour: state.alarmTime.hour,
  //     minute: state.alarmTime.minute,
  //     period: state.alarmTime.period.index == 0 ? "AM" : "PM",
  //   );

  //   // Fetch existing alarms from SharedPreferences
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? alarmStrings = prefs.getStringList('alarms');

  //   List<Alarm> _alarms = alarmStrings != null
  //       ? alarmStrings.map((json) => Alarm.fromJson(jsonDecode(json))).toList()
  //       : [];

  //   // Find and update the existing alarm in the list
  //   int index = _alarms.indexWhere((alarm) =>
  //       alarm.title ==
  //       'AlarmToEdit'); // Replace 'AlarmToEdit' with the actual title you are editing

  //   if (index != -1) {
  //     Alarm existingAlarm = _alarms[index];
  //     _alarms[index] = Alarm(
  //       id: editedAlarm.id,
  //       title: editedAlarm.title,
  //       selectedDays: editedAlarm.selectedDays,
  //       isSwitched: editedAlarm.isSwitched,
  //       isAM: editedAlarm.isAM,
  //       hour: editedAlarm.hour,
  //       minute: editedAlarm.minute,
  //       period: editedAlarm.period,
  //     );
  //   } else {
  //     // Add a new alarm to the list
  //     _alarms.add(editedAlarm);
  //   }

    // Save the updated list to SharedPreferences
  //   List<String> updatedAlarmStrings =
  //       _alarms.map((alarm) => jsonEncode(alarm.toJson())).toList();
  //   await prefs.setStringList('alarms', updatedAlarmStrings);

  //   // You may emit a new state or perform other actions as needed
  //   // emit(UpdatedAlarmsState(_alarms, ''));

  //   // Example: Navigate back after saving
  //   Navigator.pop(context);
  // }

  void updateAlarm(Alarm updatedAlarm, int index, BuildContext context) async {
    // Fetch existing alarms from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? alarmStrings = prefs.getStringList('alarms');

    List<Alarm> _alarms = alarmStrings != null
        ? alarmStrings.map((json) => Alarm.fromJson(jsonDecode(json))).toList()
        : [];

    // Update the existing alarm in the list
    if (index != -1 && index < _alarms.length && index != null) {
      _alarms[index] = updatedAlarm;
    } else {
      // Handle the case where the index is not valid (optional)
    }

    List<String> updatedAlarmStrings =
        _alarms.map((alarm) => jsonEncode(alarm.toJson())).toList();
    await prefs.setStringList('alarms', updatedAlarmStrings);

    Navigator.pop(context, updatedAlarm);
  }
}
