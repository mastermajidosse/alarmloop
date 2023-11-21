import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Style {
  static String barlow = 'Barlow';

  static Color blackClr = Colors.black;
  static Color greyColor = Colors.grey;
  static Color whiteClr = Colors.white;

  static TextStyle textStyleBtn() => TextStyle(
        fontFamily: barlow,
        fontSize: 17,
      );
  static TextStyle clockStyle() => TextStyle(
        fontFamily: barlow,
        fontSize: 40.sp,
      );
  static TextStyle isSelectedDayStyle() => TextStyle(
        fontFamily: barlow,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Style.blackClr,
      );
  static TextStyle isNotSelectedDayStyle() => TextStyle(
        fontFamily: barlow,
        fontSize: 12,
        color: Style.greyColor,
      );
}
