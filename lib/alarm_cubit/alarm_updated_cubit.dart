// Define the cubit
import 'package:alarmloop/alarm_cubit/alarm_updated_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/alarm.dart';

class UpdatedAlarmsCubit extends Cubit<UpdatedAlarmsState> {
  UpdatedAlarmsCubit() : super(UpdatedAlarmsState([]));

  void loadAlarms() {
    // Replace this with actual data fetching logic
    List<Alarm> demoAlarms = [
      Alarm('Alarm 1', 'Mon Tue Wed', true),
      Alarm('Alarm 2', 'Thu Fri Sat', false),
      Alarm('Alarm 2', 'Thu Fri Sat', false),
      Alarm('Alarm 2', 'Thu Fri Sat', false),
      Alarm('Alarm 2', 'Thu Fri Sat', false),
      // Add more demo data as needed
    ];

    emit(UpdatedAlarmsState(demoAlarms));
  }
}
