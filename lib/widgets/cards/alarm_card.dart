import 'package:alarmloop/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../alarm_cubit/alarm_updated_cubit.dart';
import '../../model/alarm.dart';
import '../../ui/edit/updated_edited_screen.dart';

class AlarmCard extends StatelessWidget {
  final Alarm alarm;

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
        _showDeleteConfirmationDialog(context);
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
                          alarm.isAM
                              ? Icons.wb_sunny_outlined
                              : Icons.dark_mode_outlined,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          alarm.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Switch.adaptive(
                      value: alarm.isSwitched,
                      onChanged: (value) {
                        print(
                            'Alarm ${alarm.title} is ${value ? 'on' : 'off'}');
                      },
                    ),
                  ],
                ),
                SizedBox(height: 4),
                buildDaysRow(alarm.selectedDays),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getFormattedSelectedDays(String selectedDays) {
    List<String> daysAbbreviation = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    List<String> selectedDaysList = selectedDays.split(' ');

    String formattedDays = '';
    for (int i = 0; i < daysAbbreviation.length; i++) {
      if (selectedDaysList[i] == '1') {
        formattedDays += daysAbbreviation[i] + ' ';
      }
    }

    return formattedDays.trim();
  }
  
 Widget buildDaysRow(String selectedDays) {
  List<String> allDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  return Row(
    children: allDays.map((day) {
      bool isSelected = selectedDays.contains(day);
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        margin: EdgeInsets.only(right: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.3),
        ),
        child: Text(
          day,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      );
    }).toList(),
  );
}


  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Alarm?'),
          content: Text('Are you sure you want to delete this alarm?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteAlarm(context);
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

 void _deleteAlarm(BuildContext context) {
  context.read<UpdatedAlarmsCubit>().deleteAlarm(alarm);
  Navigator.of(context).pop(); // Close the confirmation dialog
}

}
