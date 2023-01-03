import 'package:flutter/material.dart';

import 'package:meeja/core/constants/colors.dart';
import 'package:meeja/screens/groups/all_user.dart';

import 'package:meeja/screens/widget/sub_button.dart';
import 'package:provider/provider.dart';

import '../widget/custom_appBar.dart';

import 'group_provider.dart';

class GroupInfo extends StatelessWidget {
  // GroupModel? getGroup;

  // GroupInfo({this.getGroup});

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(builder: (context, model, child) {
      return Scaffold(
        appBar: CustomAppBar(
          title: Center(
            child: Text(
              "Group Info",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        model.getGroupList[model.selectedGroup].groupName!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: SubButton(
                        BText: "Add Member",
                        color: orangeColor,
                        onpress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllUser(
                                  //    getGroup: getGroup,
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                itemCount:
                    model.getGroupList[model.selectedGroup].members!.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 16),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/img7.png'),
                              radius: 20.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                model.getGroupList[model.selectedGroup]
                                    .memberName![index],
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
                            style: TextStyle(
                                color: orangeColor,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                      //crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
