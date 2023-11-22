import '../../model/alarm.dart';

class AlarmsStateUpdated {
  final List<Alarm> alarms;

  AlarmsStateUpdated(this.alarms);

  AlarmsStateUpdated copyWith({List<Alarm>? alarms}) {
    return AlarmsStateUpdated(
      alarms ?? this.alarms,
    );
  }
}
