import 'package:flutter/material.dart';

class SubButton extends StatelessWidget {
  final String BText;
  final color;
  final onpress;
  final style;
  const SubButton(
      {required this.BText, this.color, required this.onpress, this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 10),
      // width: 160,

      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        clipBehavior: Clip.hardEdge,
        onPressed: onpress,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          child: Text(
            BText,
            style: style,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: StadiumBorder(),

          // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //   RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(60.0),
          //   ),
          // ),
        ),
      ),
    );
  }
}
