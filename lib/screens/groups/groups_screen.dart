import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meeja/core/models/groups_model.dart';
import 'package:meeja/screens/widget/custom_group.dart';

import '../../core/models/person_model.dart';
import '../widget/custom_connection.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 5,
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        backgroundColor: Color(0xffFEF6F5),
        title: Center(
            child: Text(
          "Groups",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        )),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_active_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          itemCount: groups.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 16),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return CustomGroup(
              title2: groups[index].title2,
              image2: groups[index].image2,
            );
          },
        ),
      ),
    );
  }
}
