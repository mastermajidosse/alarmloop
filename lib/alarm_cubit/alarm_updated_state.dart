import '../model/alarm.dart';

// Define the state
class UpdatedAlarmsState {
  final List<Alarm> alarms;
  final dynamic newSelectedDays;

  UpdatedAlarmsState(this.alarms,this.newSelectedDays);
}
