import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/alarm.dart';
import 'update_alarm_state.dart';

class AlarmsCubitUpdated extends Cubit<AlarmsStateUpdated> {
  AlarmsCubitUpdated() : super(AlarmsStateUpdated([]));

  void updateAlarm(
    Alarm updatedAlarm,
  ) {
    final int index =
        state.alarms.indexWhere((alarm) => alarm.id == updatedAlarm.id);

    if (index != -1) {
      final List<Alarm> updatedAlarms = List.from(state.alarms);
      updatedAlarms[index] = updatedAlarm;
      emit(state.copyWith(alarms: updatedAlarms));
    }
  }

  void updateAlarmList(List<Alarm> updatedAlarms) {
    emit(state.copyWith(alarms: updatedAlarms));
  }
}
