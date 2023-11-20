class Alarm {
  final String title;
  final String selectedDays;
  final bool isSwitched;
  final bool isAM;
  final int hour;
  final int minute;
  final String period;

  Alarm( {
    required this.title,
    required this.selectedDays,
    required this.isSwitched,
    required this.isAM,
    required this.hour,
    required this.minute,
    required this.period,
  });

  // Factory method to create an Alarm instance from a JSON map
  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      title: json['title'],
      selectedDays: json['selectedDays'],
      isSwitched: json['isSwitched'],
      isAM: json['isAM'],
      hour: json['hour'],
      minute: json['minute'],
      period: json['period'],
    );
  }

  // Convert the Alarm instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'selectedDays': selectedDays,
      'isSwitched': isSwitched,
      'isAM': isAM,
      'hour': hour,
      'minute': minute,
      'period': period,
    };
  }
}
