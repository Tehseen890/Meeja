import 'package:flutter/material.dart';

class CustomConnection extends StatefulWidget {
  final title;
  final image1;

  CustomConnection({
    this.image1,
    this.title,
  });

  @override
  State<CustomConnection> createState() => CustomConnectionState();
}

class CustomConnectionState extends State<CustomConnection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 12),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            //backgroundColor: Color(0xffC60000),
            backgroundImage: AssetImage(widget.image1),
            radius: 23,
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
          ),
          Text(
            widget.title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
