import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData iconData;
  final String text;
  const MyIconButton({
    Key? key,
    this.onPressed,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130.w,
      height: 40.h,
      child: IconButton(
        onPressed: onPressed,
        icon: Row(
          children: [
            Icon(
              iconData,
              color: Colors.blue,
            ),
            SizedBox(width: 4.w),
            Text(
              text,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
