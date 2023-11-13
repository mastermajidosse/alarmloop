import 'package:alarmloop/model/sound_model.dart';

class AlarmModel {
  final int id;
  SoundModel sound;
  bool isEnabled;
  String ringTime;
  String loopInterval;

  AlarmModel({
    required this.id,
    required this.sound,
    this.isEnabled = false,
    this.ringTime = '--:--',
    this.loopInterval = '',
  });

  Map<String, Object> toMap() => {
        "id": id,
        "sound": sound.toMap(),
        "isEnabled": isEnabled,
        "ringTime": ringTime,
        "loopInterval": loopInterval,
      };

  factory AlarmModel.fromMap(Map<String, dynamic> json) => AlarmModel(
        id: json["id"] as int,
        sound: SoundModel.fromMap(json["sound"]),
        isEnabled: json["isEnabled"] as bool,
        ringTime: json["ringTime"] as String,
        loopInterval: json["loopInterval"] as String,
      );
}
