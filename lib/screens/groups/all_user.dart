import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/models/groups_model.dart';
import 'group_provider.dart';

class AllUser extends StatelessWidget {
  // GroupModel? getGroup;

  // AllUser({this.getGroup});
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(builder: (context, model, child) {
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
            model.getGroupList[model.selectedGroup].groupName.toString(),
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
          child: Stack(
            children: [
              model.isSearching == false
                  ? ListView.builder(
                      itemCount: model.isSearching == false
                          ? model.allAppUsers.length
                          : model.searchedUsers.length,

                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 16),
                      //physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 10, left: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Checkbox(
                                activeColor: orangeColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            6.0))), // Rounded Checkbox

                                checkColor: Colors.white,
                                value: model.checkBoxes[index],
                                onChanged: (value) {
                                  model.addingMember(index, value);
                                  // model.isChecked = value ?? true;
                                },
                              ),
                              CircleAvatar(
                                backgroundImage: model
                                            .locateUser.appUser.profileImage !=
                                        null
                                    ? NetworkImage(
                                        "${model.locateUser.appUser.profileImage}")
                                    : AssetImage('assets/profile_icon.png')
                                        as ImageProvider,
                                radius: 25.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  model.allAppUsers[index].userName!,
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
                      },
                    )
                  : ListView.builder(
                      itemCount: model.isSearching == false
                          ? model.allAppUsers.length
                          : model.searchedUsers.length,
                      reverse: true,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 16),
                      //physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 10, left: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Checkbox(
                                activeColor: orangeColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            6.0))), // Rounded Checkbox

                                checkColor: Colors.white,
                                value: model.checkBoxes[index],
                                onChanged: (value) {
                                  model.addingMember(index, value);
                                  // model.isChecked = value ?? true;
                                },
                              ),
                              CircleAvatar(
                                backgroundImage: model
                                            .locateUser.appUser.profileImage !=
                                        null
                                    ? NetworkImage(
                                        "${model.locateUser.appUser.profileImage}")
                                    : AssetImage('assets/profile_icon.png')
                                        as ImageProvider,
                                radius: 25.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  model.searchedUsers[index].userName!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.updateGroups();
            //  model.addingMember()
          },
          backgroundColor: Colors.white,
          foregroundColor: orangeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              18,
            ),
            side: BorderSide(color: orangeColor, width: 1.8),
          ),
          child: Icon(
            Icons.done_outline_outlined,
            size: 35,
            // color: orangeColor,
          ),
        ),
      );
    });
  }
}
