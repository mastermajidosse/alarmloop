import 'package:bloc/bloc.dart';
import 'set_alarm_time_state.dart';



class SetAlarmTimeCubit extends Cubit<SetAlarmTimeState> {
  SetAlarmTimeCubit() : super(SetAlarmTimeState(DateTime.now()));

  void updateAlarmTime(DateTime newTime) {
    emit(SetAlarmTimeState(newTime));
  }
}