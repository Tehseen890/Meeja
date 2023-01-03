import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class CustomFAB extends StatelessWidget {
  final void Function()? onPressed;
  const CustomFAB({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.82,
      child: Container(
        //  padding: EdgeInsets.all(10),
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: orangeColor,
          foregroundColor: orangeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              50,
            ),
            //  side: BorderSide(color: orangeColor, width: 1.8),
          ),
          child: Icon(
            Icons.add,
            size: 45,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
