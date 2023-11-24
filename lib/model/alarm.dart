class Alarm {
   int id; // Add a unique identifier
   String title;
   String selectedDays;
   bool isSwitched;
   bool isAM;
   int hour;
   int minute;
   String period;

  Alarm(
    this.id,
    this.title,
    this.selectedDays,
    this.isSwitched,
    this.isAM,
    this.hour,
    this.minute,
    this.period,
  );

  // Factory method to create an Alarm instance from a JSON map
  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
       json['id'], // Make sure to include 'id' in your JSON data
      json['title'],
      json['selectedDays'],
       json['isSwitched'],
       json['isAM'],
      json['hour'],
       json['minute'],
       json['period'],
    );
  }

  // Convert the Alarm instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id, // Include 'id' in the JSON representation
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
