import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedbutton extends StatelessWidget {
  final title;
  final getColor;
  final onPressed;
  final style;
  CustomElevatedbutton({this.title, this.getColor, this.onPressed, this.style});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // elevation: 4,
        shape: StadiumBorder(),
        primary: getColor,
        // This is what you need!
        padding: EdgeInsets.only(left: 22.w, right: 22.w),
      ),
      child: Text(title, style: style),
    );
  }
}
