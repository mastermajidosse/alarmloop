class SoundModel {
  final int id;
  String name;
  String image;
  String sound;
  String duration;

  SoundModel({
    required this.id,
    required this.name,
    required this.image,
    required this.sound,
    required this.duration,
  });

  Map<String, Object> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "sound": sound,
        "duration": duration,
      };

  factory SoundModel.fromMap(Map<String, dynamic> json) => SoundModel(
        id: json["id"] as int,
        name: json["name"] as String,
        image: json["image"] as String,
        sound: json["sound"] as String,
        duration: json["duration"] as String,
      );
}

List<SoundModel> sounds = [
  SoundModel(
    id: 1,
    name: 'Bird 1',
    image: '1.png',
    sound: 'first.mp3',
    duration: '00:13',
  ),
  SoundModel(
    id: 2,
    name: 'Bird 2',
    image: '2.png',
    sound: 'second.mp3',
    duration: '00:34',
  ),
  SoundModel(
    id: 3,
    name: 'Bird 3',
    image: '3.png',
    sound: 'third.mp3',
    duration: '00:09',
  ),
  SoundModel(
    id: 4,
    name: 'Bird 4',
    image: '4.png',
    sound: 'forth.mp3',
    duration: '00:01',
  ),
  SoundModel(
    id: 5,
    name: 'Bird 5',
    image: '1.png',
    sound: 'fifth.wav',
    duration: '00:13',
  ),
  SoundModel(
    id: 6,
    name: 'Bird 6',
    image: '2.png',
    sound: 'sext.wav',
    duration: '00:34',
  ),
  SoundModel(
    id: 7,
    name: 'Bird 7',
    image: '3.png',
    sound: 'sext.wav',
    duration: '00:09',
  ),
  SoundModel(
    id: 8,
    name: 'Bird 8',
    image: '4.png',
    sound: 'eight.wav',
    duration: '00:01',
  ),
];
