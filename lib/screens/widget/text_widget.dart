import 'package:flutter/material.dart';

import 'package:meeja/core/constants/colors.dart';

class TextWidget extends StatelessWidget {
  final title;
  final OnTap;
  const TextWidget({this.title, this.OnTap});

  @override
  Widget build(BuildContext context) {
    {
      return InkWell(
        onTap: OnTap,
        child: Text(
          title,
          style: TextStyle(
            color: orangeColor,
          ),
        ),
      );
    }
  }
}
