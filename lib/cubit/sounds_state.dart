
import 'package:audioplayers/audioplayers.dart';

import '../model/alarm_model.dart';

class SState {
  final List<AlarmModel> alarms;
  final List<String> loopIntervals;
  final int indexPlayingSound;
  final int indexSelectedAlarm;

  const SState({
    required this.alarms,
    required this.loopIntervals,
    required this.indexPlayingSound,
    required this.indexSelectedAlarm,
  });

  // Your existing copyWith method

  SState copyWithPlayerState(playerState) {
    return SState(
      alarms: alarms,
      loopIntervals: loopIntervals,
      indexPlayingSound: playerState == PlayerState.playing ? indexPlayingSound : -1,
      indexSelectedAlarm: indexSelectedAlarm,
    );
  }
}
