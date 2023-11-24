import 'package:just_audio/just_audio.dart';

import '../../model/alarm.dart';

class AlarmsStateUpdated {
  AlarmsStateUpdated({
    required this.alarms,
    this.isLoading = false,
    required this.indexSelectedAlarm,
  });
  List<Alarm> alarms = [];
  int indexSelectedAlarm =-1;
  bool isLoading;



}
