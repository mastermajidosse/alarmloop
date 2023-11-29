import 'package:alarmloop/cubit/alarm_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../ui/edit/updated_edited_screen.dart';
import '../utils/style.dart';

String getFormattedSelectedDays(String selectedDays,index) {
  List<String> daysAbbreviation = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  List<String> selectedDaysList = selectedDays.split(' ');

  List<String> daysNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  String formattedDays = '';
  for (int i = 0; i < daysAbbreviation.length; i++) {
    if (selectedDaysList[i] == '1') {
      formattedDays += '${daysNames[i]} ';
    }
  }

  return formattedDays.trim();
}

Widget buildDaysRow(String selectedDays,index) {
  List<String> allDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  return Row(
    children: allDays.map((day) {
      bool isSelected = selectedDays.contains(day);
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        margin: EdgeInsets.only(right: 4.0),
        child: Text(
          day,
          style: isSelected
              ? Style.isSelectedDayStyle()
              : Style.isNotSelectedDayStyle(),
        ),
      );
    }).toList(),
  );
}

void showDeleteConfirmationDialog(BuildContext context, alarm, index) {
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
              _deleteAlarm(context, alarm, index);
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

void _deleteAlarm(BuildContext context, alarm, index) {
  context.read<AlarmCubit>().deleteAlarm(context, index);
}

Widget buildEmptyState(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No alarms yet',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, UpdatedEditAlarmForm.routeName);
          },
          child: Text('Add Alarm'),
        ),
      ],
    ),
  );
}
