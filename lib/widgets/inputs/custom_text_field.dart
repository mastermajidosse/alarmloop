import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final String label;
  final String initialAlarm;
  final IconData icon;
  final ValueChanged<String> onChanged;

  CustomTextField({
    required this.label,
    required this.icon,
    required this.initialAlarm,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: TextFormField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: label,
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              initialValue: initialAlarm,
            ),
          ),
        ],
      ),
    );
  }
}
