import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:meeja/core/constants/colors.dart';

class CustomGroup extends StatefulWidget {
  final title2;
  final image2;
  CustomGroup({this.title2, this.image2});

  @override
  State<CustomGroup> createState() => _CustomGroupState();
}

class _CustomGroupState extends State<CustomGroup> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              CircleAvatar(
                //backgroundColor: Color(0xffC60000),
                backgroundImage: AssetImage('assets/img7.png'),
                radius: 25.0,
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
              ),
              Text(
                widget.title2,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text('Edit',
                    style: TextStyle(
                        color: orangeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextButton(
                  onPressed: () {},
                  child: Text('Delete',
                      style: TextStyle(
                          color: orangeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ),
              ),
            ],
          ),
        ],
        //crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
