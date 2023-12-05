import 'package:alarmloop/cubit/day_selection_state.dart';
import 'package:bloc/bloc.dart';

enum DaySelectionEvent { toggleDay }



class DaySelectionCubit extends Cubit<DaySelectionState> {
  static List<bool> _selectedDays = List.generate(7, (index) => false);

  DaySelectionCubit() : super(DaySelectionState(_selectedDays));

  void toggleDay(int index) {
    final List<bool> updatedSelection = List.from(_selectedDays);
    updatedSelection[index] = !updatedSelection[index];
    _selectedDays = updatedSelection;
    emit(DaySelectionState(updatedSelection));
  }

  bool isSelected(int index) {
    return _selectedDays[index];
  }
}