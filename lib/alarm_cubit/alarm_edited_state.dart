import 'package:flutter/material.dart';

class EditAlarmState {
  final bool isAM;
  final TimeOfDay alarmTime;
  final bool isSwitched;
  final String selectedDays; // Add this line

  EditAlarmState({
    required this.isAM,
    required this.alarmTime,
    required this.isSwitched,
    required this.selectedDays, // Add this line
  });

  // Copy method to create a new state with updated properties
  EditAlarmState copyWith({
    bool? isAM,
    TimeOfDay? alarmTime,
    bool? isSwitched,
    String? selectedDays, // Add this line
  }) {
    return EditAlarmState(
      isAM: isAM ?? this.isAM,
      alarmTime: alarmTime ?? this.alarmTime,
      isSwitched: isSwitched ?? this.isSwitched,
      selectedDays: selectedDays ?? this.selectedDays, // Add this line
    );
  }
}
