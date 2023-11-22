// Define the cubit
import 'dart:convert';

import 'package:alarmloop/alarm_cubit/alarm_updated_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/alarm.dart';

class UpdatedAlarmsCubit extends Cubit<UpdatedAlarmsState> {
  UpdatedAlarmsCubit() : super(UpdatedAlarmsState([], []));

  Future<void> loadAlarms() async {
    try {
      List<Alarm> fetchedAlarms = await fetchDataFromExternalSource();
      emit(UpdatedAlarmsState(fetchedAlarms, []));
    } catch (error) {
      print("Error loading alarms: $error");
    }
  }

  Future<List<Alarm>> fetchDataFromExternalSource() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? alarmStrings = prefs.getStringList('alarms');

    if (alarmStrings != null) {
      List<Alarm> demoAlarms =
          alarmStrings.map((json) => Alarm.fromJson(jsonDecode(json))).toList();
      return demoAlarms;
    } else {
      return [];
    }
  }

  //add function
  Future<void> addAlarm(Alarm newAlarm) async {
    List<Alarm> currentAlarms = state.alarms;
    List<Alarm> updatedAlarms = [...currentAlarms, newAlarm];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedAlarmStrings =
        updatedAlarms.map((alarm) => jsonEncode(alarm.toJson())).toList();
    await prefs.setStringList('alarms', updatedAlarmStrings);

    emit(UpdatedAlarmsState(updatedAlarms, []));
  }

  // delete function
  Future<void> deleteAlarm(Alarm alarm) async {
    List<Alarm> currentAlarms = state.alarms;
    List<Alarm> updatedAlarms = List.from(currentAlarms)..remove(alarm);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedAlarmStrings =
        updatedAlarms.map((alarm) => jsonEncode(alarm.toJson())).toList();
    await prefs.setStringList('alarms', updatedAlarmStrings);

    emit(UpdatedAlarmsState(updatedAlarms, []));
  }

  void updateSelectedDays(String newSelectedDays,index) {
    List<Alarm> updatedAlarms = state.alarms.map((alarm) {
      return Alarm(
        id: index,
        title: alarm.title,
        selectedDays: newSelectedDays,
        isAM: alarm.isAM,
        isSwitched: alarm.isSwitched,
        hour: alarm.hour,
        minute: alarm.minute,
        period: alarm.period,
      );
    }).toList();

    emit(UpdatedAlarmsState(updatedAlarms, newSelectedDays));
  }

 void updateAlarmSelectedDays(int alarmIndex, List<bool> newSelectedDays) {
  List<Alarm> updatedAlarms = List.from(state.alarms);

  // Check if alarmIndex is within the valid range
  if (alarmIndex >= 0 && alarmIndex < updatedAlarms.length) {
    Alarm oldAlarm = updatedAlarms[alarmIndex];

    // Create a new Alarm instance with updated selectedDays
    Alarm updatedAlarm = Alarm(
      id: alarmIndex,
      isSwitched: oldAlarm.isSwitched,
      isAM: oldAlarm.isAM,
      title: oldAlarm.title,
      selectedDays:
          newSelectedDays.map((selected) => selected ? '1' : '0').join(' '),
      hour: oldAlarm.hour,
      minute: oldAlarm.minute,
      period: oldAlarm.period,
    );

    updatedAlarms[alarmIndex] = updatedAlarm;
    emit(UpdatedAlarmsState(updatedAlarms, ''));
  } else {
    print('Invalid alarm index: $alarmIndex');
  }
}

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
