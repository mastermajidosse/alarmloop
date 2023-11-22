import 'package:alarmloop/cubit/day_selection_state.dart';
import 'package:bloc/bloc.dart';

enum DaySelectionEvent { toggleDay }

class DaySelectionCubit extends Cubit<DaySelectionState> {
  DaySelectionCubit()
      : super(DaySelectionState(List.generate(7, (index) => false)));

  void toggleDay(int index) {
    final List<bool> updatedSelection = List.from(state.selectedDays);
    updatedSelection[index] = !updatedSelection[index];
    emit(DaySelectionState(updatedSelection));
  }

  bool isSelected(int index) {
    return state.selectedDays[index];
  }
}
