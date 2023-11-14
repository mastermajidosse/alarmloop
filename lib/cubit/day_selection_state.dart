import 'package:equatable/equatable.dart';

class DaySelectionState extends Equatable {
  final List<bool> selectedDays;

  const DaySelectionState(this.selectedDays);

  @override
  List<Object?> get props => [selectedDays];
}
