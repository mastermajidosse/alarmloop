import 'dart:convert';
import 'package:alarmloop/ui/edit/updated_edited_screen.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/alarm.dart';
import 'update_alarm_state.dart';

class AlarmsCubitUpdated extends Cubit<AlarmsStateUpdated> {
  AlarmsCubitUpdated()
      : super(AlarmsStateUpdated(alarms: [], indexSelectedAlarm: -1));

  void addNewAlarm(BuildContext context) {
    state.indexSelectedAlarm = state.alarms.length;
    state.alarms.add(Alarm(DateTime.now().millisecond,'','M T T F',false,true,5,05,'5'));

    emit(AlarmsStateUpdated(
      alarms: state.alarms,
      indexSelectedAlarm: state.indexSelectedAlarm,
    ));

    Navigator.pushNamed(context, UpdatedEditAlarmForm.routeName);
  }

  // void updateAlarm(
  //   Alarm updatedAlarm,
  // ) {
  //   final int index =
  //       state.alarms.indexWhere((alarm) => alarm.id == updatedAlarm.id);

  //   if (index != -1) {
  //     final List<Alarm> updatedAlarms = List.from(state.alarms);
  //     updatedAlarms[index] = updatedAlarm;
  //     emit(state.copyWith(alarms: updatedAlarms));
  //   }
  // }

  // void updateAlarmList(List<Alarm> updatedAlarms) {
  //   emit(state.copyWith(alarms: updatedAlarms));
  // }
  void saveAlarm(BuildContext context) async {
    if (prefs == null) {
      await initPrefs();
    }

    String json = jsonEncode(state.alarms.map((e) => e.toJson()).toList());
    await prefs!.setString('alarms', json);

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  SharedPreferences? prefs;

  Future<bool> initPrefs() async {
    debugPrint('Init Preferences start');
    prefs = await SharedPreferences.getInstance();
    debugPrint('Init Preferences end');
    return true;
  }

  // New method to set the list of alarms
  void setAlarmsList(List<Alarm> alarms) {
    emit(
      AlarmsStateUpdated(
        alarms: alarms,
        indexSelectedAlarm: state.indexSelectedAlarm,
      ),
    ); // Assuming you have an AlarmsLoaded state
  }

  void deleteAlarm(BuildContext context, int id) async {
    if (prefs == null) {
      await initPrefs();
    }

    state.alarms.removeWhere((element) => element.id == id);

    String json = jsonEncode(state.alarms.map((e) => e.toJson()).toList());
    await prefs!.setString('alarms', json);

    // deactivate the alarm
    AndroidAlarmManager.cancel(id);

    emit(AlarmsStateUpdated(
      alarms: state.alarms,
      indexSelectedAlarm: state.indexSelectedAlarm,
    ));

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void getAlarmsList() async {
    if (prefs == null) {
      await initPrefs();
    }

    String data = prefs!.getString('alarms') ?? '[]';

    state.alarms = (json.decode(data) as List)
        .map((alarm) => Alarm.fromJson(alarm))
        .toList();

    emit(AlarmsStateUpdated(
      alarms: state.alarms,
      indexSelectedAlarm: -1,
    ));
  }

  void editAlarm(BuildContext context, index) {
    state.indexSelectedAlarm = index;
    emit(AlarmsStateUpdated(
      alarms: state.alarms,
      indexSelectedAlarm: state.indexSelectedAlarm,
    ));

    Navigator.pushNamed(context, UpdatedEditAlarmForm.routeName);
  }

  void cancelEditAlarm(BuildContext context) {
    Navigator.pop(context);
    getAlarmsList();
  }
}
