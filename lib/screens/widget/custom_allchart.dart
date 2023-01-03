import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:meeja/core/constants/colors.dart';

class CustomAllChat extends StatefulWidget {
  final title2;
  final image2;
  CustomAllChat({this.title2, this.image2});

  @override
  State<CustomAllChat> createState() => CustomAllChatState();
}

class CustomAllChatState extends State<CustomAllChat> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10, left: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            activeColor: orangeColor,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(6.0))), // Rounded Checkbox

            checkColor: Colors.white,
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
          CircleAvatar(
            backgroundImage: NetworkImage('assets/img7.png'),
            radius: 25.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              widget.title2,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
        //crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
