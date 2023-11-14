part of 'alarm_cubit.dart';

class AlarmState {
  AlarmState({
    required this.alarms,
    this.isLoading = false,
    this.indexPlayingSound = -1,
    this.indexSelectedSound = 0,
    this.loopIntervals = const ['1 min', '20 min', '1 h'],
    required this.indexSelectedAlarm,
  });

  List<AlarmModel> alarms = [];
  int indexSelectedAlarm = -1;
  bool isLoading;

  final AudioPlayer player = AudioPlayer();
  int indexPlayingSound;

  int indexSelectedSound;
  List<String> loopIntervals;
}
