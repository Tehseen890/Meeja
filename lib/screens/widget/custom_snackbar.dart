import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

customSnackBar(BuildContext context, String message,
    {Duration? duration,
    SnackBarAction? action,
    SnackBarBehavior behavior = SnackBarBehavior.floating}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context)
      .showSnackBar(behavior == SnackBarBehavior.floating
          ? SnackBar(
              behavior: behavior,
              margin: EdgeInsets.only(
                bottom: 20.h,
                left: 20.w,
                right: 20.w,
              ),
              // width: ,
              action: action,
              duration: duration ?? Duration(seconds: 4),
              content: Text('$message'),
            )
          : SnackBar(
              behavior: behavior,
              // margin: EdgeInsets.only(
              //   bottom: 20.h,
              //   left: 20.w,
              //   right: 20.w,
              // ),
              // width: ,
              action: action,
              duration: duration ?? Duration(seconds: 3),
              content: SafeArea(
                child: Text('$message'),
              ),
            ));
}
