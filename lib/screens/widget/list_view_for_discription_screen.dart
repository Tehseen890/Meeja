import 'package:flutter/material.dart';

class DiscriptionScreenListView extends StatelessWidget {
  const DiscriptionScreenListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 70,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/img7.png'),
          ),
          SizedBox(
            height: 5,
          ),
          Text('Name'),
        ],
      ),
    );
  }
}
