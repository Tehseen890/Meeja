import 'package:flutter/material.dart';
import 'package:meeja/core/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final title;
  final onTap;

  const CustomButton({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 50,
      child: ElevatedButton(
        clipBehavior: Clip.hardEdge,
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: orangeColor,
          shape: StadiumBorder(),

          // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //   RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(60.0),
          //   ),
          // ),
        ),
        // style: ButtonStyle(
        //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //       RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(25.0),
        //   )),
        // ),
      ),
    );
  }
}
