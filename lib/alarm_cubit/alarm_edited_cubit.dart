import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../model/alarm.dart';
import 'alarm_edited_state.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EditAlarmCubit extends Cubit<EditAlarmState> {
  EditAlarmCubit()
      : super(EditAlarmState(
          isAM: true,
          alarmTime: TimeOfDay.now(),
          selectedDays: '',
          isSwitched: false,
        ));

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

  void save(BuildContext context) async {
    // Create a new edited alarm
    Alarm editedAlarm = Alarm(
      title: 'Edited Alarm', // You may use the actual title logic
      selectedDays: state.selectedDays,
      isSwitched: state.isSwitched,
      isAM: state.isAM,
      hour: state.alarmTime.hour,
      minute: state.alarmTime.minute,
      period: state.alarmTime.period.index == 0 ? "AM" : "PM",
    );

    // Fetch existing alarms from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? alarmStrings = prefs.getStringList('alarms');

    List<Alarm> _alarms = alarmStrings != null
        ? alarmStrings.map((json) => Alarm.fromJson(jsonDecode(json))).toList()
        : [];

    // Find and update the existing alarm in the list
    int index = _alarms.indexWhere((alarm) =>
        alarm.title ==
        'AlarmToEdit'); // Replace 'AlarmToEdit' with the actual title you are editing

    if (index != -1) {
      Alarm existingAlarm = _alarms[index];
      _alarms[index] = Alarm(
        title: editedAlarm.title,
        selectedDays: editedAlarm.selectedDays,
        isSwitched: editedAlarm.isSwitched,
        isAM: editedAlarm.isAM,
        hour: editedAlarm.hour,
        minute: editedAlarm.minute,
        period: editedAlarm.period,
      );
    } else {
      // Add a new alarm to the list
      _alarms.add(editedAlarm);
    }

    // Save the updated list to SharedPreferences
    List<String> updatedAlarmStrings =
        _alarms.map((alarm) => jsonEncode(alarm.toJson())).toList();
    await prefs.setStringList('alarms', updatedAlarmStrings);

    // You may emit a new state or perform other actions as needed
    // emit(UpdatedAlarmsState(_alarms, ''));

    // Example: Navigate back after saving
    Navigator.pop(context);
  }
}
