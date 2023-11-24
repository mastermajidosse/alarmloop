import 'package:alarmloop/model/alarm_model.dart';
import 'package:alarmloop/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../alarm_cubit/alarm_updated_cubit.dart';
import '../../core/core.dart';
import '../../model/alarm.dart';
import '../../ui/edit/updated_edited_screen.dart';

class AlarmCard extends StatelessWidget {
  final AlarmModel alarm;

  AlarmCard({required this.alarm});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the EditAlarmScreen when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdatedEditAlarmForm(),
          ),
        );
      },
      onLongPress: () {
        // Show a confirmation dialog when the card is long-pressed
        showDeleteConfirmationDialog(context, alarm, alarm.id);
      },
      child: Container(
        margin: const EdgeInsets.all(6.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          alarm.isAm
                              ? Icons.wb_sunny_outlined
                              : Icons.dark_mode_outlined,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          alarm.ringTime,
                          style: Style.clockStyle(),
                        ),
                      ],
                    ),
                    Switch.adaptive(
                      value: alarm.isEnabled,
                      onChanged: (value) {
                        print(
                            'Alarm ${alarm.title} is ${value ? 'on' : 'off'}');
                      },
                      activeTrackColor: Style.blackClr,
                      activeColor: Style.greenClr,
                      inactiveThumbColor: Style.blackClr,
                      inactiveTrackColor: Style.greyColor,
                    ),
                  ],
                ),
                SizedBox(height: 4),
                // buildDaysRow(alarm.selectedDays!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
