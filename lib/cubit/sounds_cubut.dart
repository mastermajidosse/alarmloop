import 'package:just_audio/just_audio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sounds_state.dart';

class SoundsCubit extends Cubit<SState> {
  final AudioPlayer player = AudioPlayer();

  SoundsCubit() : super(const SState(alarms: [], loopIntervals: [], indexPlayingSound: -1, indexSelectedAlarm: -1)) {
    player.playerStateStream.listen((playerState) {
      emit(state.copyWithPlayerState(playerState));
      
    });
  }

  void playPauseAudio(int index, String sound) async {
    if (player.playing) {
      await player.stop();
    } else {
      await player.setAsset('sounds/$sound');
      await player.play();
    }
  }
}
