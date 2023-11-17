import 'package:flutter/material.dart';

import '../../model/alarm.dart';

class AlarmCard extends StatelessWidget {
  final Alarm alarm;

  AlarmCard({required this.alarm});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.alarm),
                Switch(
                  value: alarm.isOn,
                  onChanged: (value) {
                    // Add logic to update the alarm state when the switch is toggled
                    // For now, just print a message
                    print('Alarm ${alarm.title} is ${value ? 'on' : 'off'}');
                  },
                ),
              ],
            ),
            Text(
              alarm.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            buildDaysRow(alarm.selectedDays),
          ],
        ),
      ),
    );
  }

  Widget buildDaysRow(String selectedDays) {
    List<String> allDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: allDays.map((day) {
          bool isSelected = selectedDays.contains(day);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Chip(
              label: Text(
                day,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
            ),
          );
        }).toList(),
      ),
    );
  }
}
