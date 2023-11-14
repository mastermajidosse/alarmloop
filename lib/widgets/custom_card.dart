import 'package:alarmloop/cubit/day_selection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/day_selection_cubit.dart';

class DayCard extends StatelessWidget {
  final int index;

  DayCard(this.index);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<DaySelectionCubit>().toggleDay(index);
      },
      child: BlocBuilder<DaySelectionCubit, DaySelectionState>(
        builder: (context, state) {
          final isSelected = state.selectedDays[index];

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
                getDayAbbreviation(index),
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
        return 'Mon';
      case 1:
        return 'Tue';
      case 2:
        return 'Wed';
      case 3:
        return 'Thu';
      case 4:
        return 'Fri';
      case 5:
        return 'Sat';
      case 6:
        return 'Sun';
      default:
        return '';
    }
  }
}
