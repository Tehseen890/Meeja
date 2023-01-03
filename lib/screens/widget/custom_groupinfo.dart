import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:meeja/core/constants/colors.dart';

class CustomGroupInfo extends StatefulWidget {
  final title2;
  final image2;
  CustomGroupInfo({this.title2, this.image2});

  @override
  State<CustomGroupInfo> createState() => _CustomGroupInfoState();
}

class _CustomGroupInfoState extends State<CustomGroupInfo> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Checkbox(
                activeColor: orangeColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(5.0))), // Rounded Checkbox

                checkColor: Colors.white,
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/img7.png'),
                radius: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.title2,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Remove',
              style: TextStyle(color: orangeColor, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
        ],
        //crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
