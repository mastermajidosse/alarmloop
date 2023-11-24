part of 'alarm_cubit.dart';

class AlarmState {
  AlarmState({
    required this.alarms,
    this.isLoading = false,
    this.isAm = false,
    this.isSwitched = false,
    this.indexPlayingSound = -1,
    this.indexSelectedSound = 0,
    this.loopIntervals = const ['1 min', '20 min', '1 h'],
    required this.indexSelectedAlarm,
  });

  List<AlarmModel> alarms = [];
  int indexSelectedAlarm = -1;
  bool isLoading;
  bool isSwitched;
  bool isAm;

  final AudioPlayer player = AudioPlayer();
  int indexPlayingSound;

  int indexSelectedSound;
  List<String> loopIntervals;

    AlarmState copyWith({
    List<AlarmModel>? alarms,
    bool? isLoading,
    bool? isAm,
    bool? isSwitched,
    int? indexPlayingSound,
    int? indexSelectedSound,
    List<String>? loopIntervals,
    int? indexSelectedAlarm,
  }) {
    return AlarmState(
      alarms: alarms ?? this.alarms,
      isLoading: isLoading ?? this.isLoading,
      isAm: isAm ?? this.isAm,
      isSwitched: isSwitched ?? this.isSwitched,
      indexPlayingSound: indexPlayingSound ?? this.indexPlayingSound,
      indexSelectedSound: indexSelectedSound ?? this.indexSelectedSound,
      loopIntervals: loopIntervals ?? this.loopIntervals,
      indexSelectedAlarm: indexSelectedAlarm ?? this.indexSelectedAlarm,
    );
  }
}


