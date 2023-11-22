import 'package:alarmloop/cubit/day_selection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../alarm_cubit/alarm_updated_cubit.dart';
import '../cubit/day_selection_cubit.dart';
import '../utils/style.dart';

class DayCard extends StatelessWidget {
  final int index;
  final bool isHome;
  final int dayIndex;
  final int alarmIndex;

  const DayCard({
    required this.isHome,
    required this.index,
    required this.dayIndex,
    required this.alarmIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dispatch the toggleDay event when the card is tapped
        context.read<DaySelectionCubit>().toggleDay(dayIndex);

        // Check if it's a home card and do something specific
        if (isHome) {
          // Get the selected days from the DaySelectionCubit
          List<bool> selectedDays =
              context.read<DaySelectionCubit>().state.selectedDays;

          // Update the selected days of the corresponding alarm in UpdatedAlarmsCubit
          context
              .read<UpdatedAlarmsCubit>()
              .updateAlarmSelectedDays(alarmIndex, selectedDays);
        }
      },
      child: BlocBuilder<DaySelectionCubit, DaySelectionState>(
        builder: (context, state) {
          final isSelected =
              context.read<DaySelectionCubit>().isSelected(dayIndex);

          return Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.grey.shade200,
              border: Border.all(width: 1.0, color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                getDayAbbreviation(dayIndex),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String getDayAbbreviation(int index) {
    // Adjust the index to start from Monday
    final dayIndex = (index + 1) % 7;
    switch (dayIndex) {
      case 0:
        return 'M';
      case 1:
        return 'T';
      case 2:
        return 'W';
      case 3:
        return 'T';
      case 4:
        return 'F';
      case 5:
        return 'S';
      case 6:
        return 'S';
      default:
        return '';
    }
  }
}
