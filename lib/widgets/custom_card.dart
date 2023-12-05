import 'package:alarmloop/cubit/day_selection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/day_selection_cubit.dart';
import '../utils/style.dart';

class DayCard extends StatelessWidget {
  final int dayIndex;
  final int alarmIndex;

  const DayCard({
    required this.dayIndex,
    required this.alarmIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<DaySelectionCubit>().toggleDay(alarmIndex);
      },
      child: BlocBuilder<DaySelectionCubit, DaySelectionState>(
        builder: (context, state) {
          final isSelected = context.read<DaySelectionCubit>().isSelected(alarmIndex);
          return Center(
            child: Text(
              getDayAbbreviation(dayIndex),
              style: TextStyle(
                color: isSelected ? Style.greyColor : Style.blackClr,
                fontWeight: FontWeight.bold,
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
