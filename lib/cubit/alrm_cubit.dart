import 'package:flutter_bloc/flutter_bloc.dart';

import 'alrm_state.dart';

class AlrmCubit extends Cubit<AlrmState> {
  AlrmCubit() : super(AlrmState());

  void setAlarmTime(DateTime alarmTime) {
    emit(AlrmState(alarmTime: alarmTime));
  }

  void setAlarmDays(List<int> alarmDays) {
    emit(AlrmState(alarmDays: alarmDays));
  }

  void toggleAlarmEnabled(bool isEnabled) {
    emit(AlrmState(isEnabled: isEnabled));
  }
}
