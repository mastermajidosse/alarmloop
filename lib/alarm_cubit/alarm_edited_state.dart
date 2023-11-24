import 'package:flutter/material.dart';

import '../model/alarm.dart';

class EditAlarmState {
  final int id;
  final bool isAM;
  final TimeOfDay alarmTime;
  final bool isSwitched;
  final String selectedDays; // Add this line

  EditAlarmState({
    required this.id,
    required this.isAM,
    required this.alarmTime,
    required this.isSwitched,
    required this.selectedDays, // Add this line
  });

  // Copy method to create a new state with updated properties
  EditAlarmState copyWith({
    int? id,
    bool? isAM,
    TimeOfDay? alarmTime,
    bool? isSwitched,
    String? selectedDays, // Add this line
  }) {
    return EditAlarmState(
      id: id ?? this.id,
      isAM: isAM ?? this.isAM,
      alarmTime: alarmTime ?? this.alarmTime,
      isSwitched: isSwitched ?? this.isSwitched,
      selectedDays: selectedDays ?? this.selectedDays, // Add this line
    );
  }

  factory EditAlarmState.fromAlarm(Alarm alarm) {
    return EditAlarmState(
      id: alarm.id!,
      isAM: alarm.isAM!,
      alarmTime: TimeOfDay(hour: alarm.hour!, minute: alarm.minute!),
      selectedDays: alarm.selectedDays!,
      isSwitched: alarm.isSwitched!,
    );
  }
}
