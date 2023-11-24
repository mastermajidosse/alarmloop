import 'package:alarmloop/model/sound_model.dart';

class AlarmModel {
  final int id;
  SoundModel sound;
  bool isEnabled;
  String ringTime;
  String loopInterval;
  String title;
  bool isAm;

  AlarmModel({
    required this.id,
    required this.sound,
    this.isEnabled = false,
    this.ringTime = '--:--',
    this.loopInterval = '',
    this.title = 'alarm',
    this.isAm = false,
  });

  Map<String, Object> toMap() => {
        "id": id,
        "sound": sound.toMap(),
        "isEnabled": isEnabled,
        "ringTime": ringTime,
        "loopInterval": loopInterval,
        "title": title,
        "isAm": isAm,
      };

  factory AlarmModel.fromMap(Map<String, dynamic> json) => AlarmModel(
        id: json["id"] as int,
        sound: SoundModel.fromMap(json["sound"]),
        isEnabled: json["isEnabled"] as bool,
        ringTime: json["ringTime"] as String,
        loopInterval: json["loopInterval"] as String,
        title: json["title"] as String,
        isAm: json["isAm"] as bool,
      );

AlarmModel copyWith({String? label,}) {
  return AlarmModel(
    id: this.id,
    sound: this.sound,
    isEnabled: this.isEnabled,
    ringTime: this.ringTime,
    loopInterval: this.loopInterval,
    title: label ?? this.title, // If label is not provided, use the existing title
    isAm: this.isAm, // If label is not provided, use the existing title
  );
}

}
