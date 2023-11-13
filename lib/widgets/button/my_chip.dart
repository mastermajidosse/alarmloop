import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyChip extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color backgroundColor, textColor;
  const MyChip({
    Key? key,
    this.onTap,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8.w),
      child: GestureDetector(
        onTap: onTap,
        child: Chip(
          backgroundColor: backgroundColor,
          label: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
