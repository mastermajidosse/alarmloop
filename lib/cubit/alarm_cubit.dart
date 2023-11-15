import 'dart:convert';

import 'package:alarmloop/model/alarm_model.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/sound_model.dart';
import '../ui/edit/edit_screen.dart';

part 'alarm_state.dart';

class AlarmCubit extends Cubit<AlarmState> {
  AlarmCubit()
      : super(AlarmState(
          alarms: [],
          indexSelectedAlarm: -1,
        ));

  SharedPreferences? prefs;

  Future<bool> initPrefs() async {
    debugPrint('Init Preferences start');
    prefs = await SharedPreferences.getInstance();
    debugPrint('Init Preferences end');
    return true;
  }

  bool isTimerOn() {
    if (state.indexSelectedAlarm == -1) {
      return true;
    }

    return state.alarms[state.indexSelectedAlarm].isEnabled;
  }

  // New method to set the list of alarms
  void setAlarmsList(List<AlarmModel> alarms) {
    emit(
      AlarmState(
        alarms: alarms,
        loopIntervals: state.loopIntervals,
        indexSelectedAlarm: state.indexSelectedAlarm,
      ),
    ); // Assuming you have an AlarmsLoaded state
  }

  void turnOnTimer(int id, String alarm) async {
    String loopInterval = state.alarms[state.indexSelectedAlarm].loopInterval;
    if (loopInterval.isEmpty) {
      return;
    }

    int minutes = int.parse(loopInterval.split(" ")[0]) *
        (loopInterval.split(" ")[1] == "min" ? 1 : 60);

    // setup alarm manager to start alarm as user wants
    AndroidAlarmManager.periodic(
      Duration(minutes: minutes),
      id,
      () => onAlarmManagerCallback(alarm),
      exact: true,
      allowWhileIdle: true,
      rescheduleOnReboot: true,
      wakeup: true,
    );
    // show visual feedback to user
    Fluttertoast.showToast(
      msg: "The alarm has been set succesfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // update alarm model
    state.alarms[state.indexSelectedAlarm].isEnabled = true;

    emit(AlarmState(
      alarms: state.alarms,
      loopIntervals: state.loopIntervals,
      indexSelectedAlarm: state.indexSelectedAlarm,
    ));
  }

  void turnOffTimer(int id) async {
    // deactivate the alarm
    AndroidAlarmManager.cancel(id);
    // show visual feedback to user
    Fluttertoast.showToast(
      msg: "The alarm has been deactivated",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // update alarm model
    state.alarms[state.indexSelectedAlarm].isEnabled = false;

    emit(AlarmState(
      alarms: state.alarms,
      loopIntervals: state.loopIntervals,
      indexSelectedAlarm: state.indexSelectedAlarm,
    ));
  }

  void deleteAlarm(BuildContext context, int id) async {
    if (prefs == null) {
      await initPrefs();
    }

    state.alarms.removeWhere((element) => element.id == id);

    String json = jsonEncode(state.alarms.map((e) => e.toMap()).toList());
    await prefs!.setString('alarms', json);

    // deactivate the alarm
    AndroidAlarmManager.cancel(id);

    emit(AlarmState(
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
        .map((alarm) => AlarmModel.fromMap(alarm))
        .toList();

    emit(AlarmState(
      alarms: state.alarms,
      indexSelectedAlarm: -1,
    ));
  }

  static void onAlarmManagerCallback(String alarm) {
    debugPrint('onAlarmManagerCallback');

    final AudioPlayer player = AudioPlayer();
    player.release();
    player.play(AssetSource('alarms/$alarm'));
  }

  void selectAlarmTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now();

    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      state.alarms[state.indexSelectedAlarm].ringTime =
          '${timeOfDay.hour}:${timeOfDay.minute}';

      emit(AlarmState(
        alarms: state.alarms,
        loopIntervals: state.loopIntervals,
        indexSelectedAlarm: state.indexSelectedAlarm,
      ));
    }
  }

  void setselectedLoopInterval(String value) {
    state.alarms[state.indexSelectedAlarm].loopInterval = value;

    emit(AlarmState(
      alarms: state.alarms,
      loopIntervals: state.loopIntervals,
      indexSelectedAlarm: state.indexSelectedAlarm,
    ));
  }

  final AudioPlayer player = AudioPlayer();
  void playPauseAudio(int index, String sound) {
    if (player.state == PlayerState.playing) {
      player.stop();

      emit(AlarmState(
        alarms: state.alarms,
        loopIntervals: state.loopIntervals,
        indexPlayingSound: state.indexPlayingSound = -1,
        indexSelectedAlarm: state.indexSelectedAlarm,
      ));
    } else {
      player.play(AssetSource('sounds/$sound'));

      emit(AlarmState(
        alarms: state.alarms,
        loopIntervals: state.loopIntervals,
        indexPlayingSound: state.indexPlayingSound = index,
        indexSelectedAlarm: state.indexSelectedAlarm,
      ));
    }
  }

  void addLoopInterval(BuildContext context, String value, String id) {
    if (value.split(' ')[0].isEmpty) {
      return;
    }

    List<String> newIntervals = [];
    for (var element in state.loopIntervals) {
      newIntervals.add(element);
    }
    if (newIntervals.length == 4) {
      newIntervals.removeLast();
    }
    newIntervals.add(value);

    // auto select new created interval
    state.alarms[state.indexSelectedAlarm].loopInterval = value;

    emit(AlarmState(
      alarms: state.alarms,
      indexPlayingSound: state.indexPlayingSound,
      loopIntervals: state.loopIntervals = newIntervals,
      indexSelectedAlarm: state.indexSelectedAlarm,
    ));

    Navigator.pop(context);
  }

  void setAlarmSound(BuildContext context, int index) {
    state.alarms[state.indexSelectedAlarm].sound = sounds[index];

    emit(AlarmState(
      alarms: state.alarms,
      loopIntervals: state.loopIntervals,
      indexPlayingSound: state.indexPlayingSound,
      indexSelectedSound: state.indexSelectedSound = index,
      indexSelectedAlarm: state.indexSelectedAlarm,
    ));

    Navigator.pop(context);
  }

  void getLoopIntervals() {
    if (state.indexSelectedAlarm == -1) {
      return;
    }

    List<String> loopIntervals = [];
    String loopInterval = state.alarms[state.indexSelectedAlarm].loopInterval;
    for (var element in state.loopIntervals) {
      loopIntervals.add(element);
    }
    if (loopInterval.isNotEmpty && !loopIntervals.contains(loopInterval)) {
      loopIntervals.add(loopInterval);
    }

    emit(AlarmState(
      alarms: state.alarms,
      loopIntervals: state.loopIntervals = loopIntervals,
      indexSelectedAlarm: state.indexSelectedAlarm,
    ));
  }

  void addNewAlarm(BuildContext context) {
    state.indexSelectedAlarm = state.alarms.length;
    state.alarms.add(
      AlarmModel(
        id: DateTime.now().millisecond,
        sound: sounds[0],
      ),
    );

    emit(AlarmState(
      alarms: state.alarms,
      indexSelectedAlarm: state.indexSelectedAlarm,
    ));

    Navigator.pushNamed(context, EditScreen.routeName);
  }

  void saveAlarm(BuildContext context) async {
    if (prefs == null) {
      await initPrefs();
    }

    String json = jsonEncode(state.alarms.map((e) => e.toMap()).toList());
    await prefs!.setString('alarms', json);

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void editAlarm(BuildContext context, index) {
    state.indexSelectedAlarm = index;

    emit(AlarmState(
      alarms: state.alarms,
      indexSelectedAlarm: state.indexSelectedAlarm,
    ));

    Navigator.pushNamed(context, EditScreen.routeName);
  }

  void cancelEditAlarm(BuildContext context) {
    Navigator.pop(context);
    getAlarmsList();
  }
}
