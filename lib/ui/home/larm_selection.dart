import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/alrm_cubit.dart';
import '../../cubit/alrm_state.dart';

class AlarmDaySelection extends StatelessWidget {
  const AlarmDaySelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlrmCubit, AlrmState>(
      builder: (context, state) {
        return CheckboxListTile(
          title: const Text('Repeat every day'),
          value: state.alarmDays?.contains(0) ?? false,
          onChanged: (value) {
            if (value!) {
              context.read<AlrmCubit>().setAlarmDays([0, 1, 2, 3, 4, 5, 6]);
            } else {
              context.read<AlrmCubit>().setAlarmDays([]);
            }
          },
        );
      },
    );
  }
}
