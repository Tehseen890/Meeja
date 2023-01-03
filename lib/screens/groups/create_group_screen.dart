import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:meeja/screens/groups/group_provider.dart';

import 'package:meeja/screens/groups/new_group_screen.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';

class CreateGroup extends StatelessWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(builder: (context, model, child) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Color(0xffFEF6F5),
            title: Center(
              child: Text(
                'CreateGroup',
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
                Container(
                  margin: REdgeInsets.only(
                      left: 15, right: 15, top: 20, bottom: 10),
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    cursorColor: orangeColor,
                    onChanged: (value) {
                      model.searchUserByName(value);
                    },
                    decoration: InputDecoration(
                      focusColor: orangeColor,
                      fillColor: orangeColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: " Search Here",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(115, 46, 46, 46)),
                    ),
                  ),
                ),
                model.selectedUsers.isEmpty
                    ? SizedBox()
                    : Container(
                        height: 80,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: model.selectedUsers.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: model.locateUser.appUser
                                                .profileImage !=
                                            null
                                        ? NetworkImage(
                                            "${model.locateUser.appUser.profileImage}")
                                        : AssetImage('assets/profile_icon.png')
                                            as ImageProvider,
                                    radius: 25,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(model.selectedUsers[index].fullName
                                      .toString()),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                Stack(
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
                                        model.changingCheckBox(index, value);
                                        // model.isChecked = value ?? true;
                                      },
                                    ),
                                    CircleAvatar(
                                      backgroundImage: model.locateUser.appUser
                                                  .profileImage !=
                                              null
                                          ? NetworkImage(
                                              "${model.locateUser.appUser.profileImage}")
                                          : AssetImage(
                                                  'assets/profile_icon.png')
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
                                      value: model.isValue,
                                      onChanged: (value) {
                                        model.isChecked = value ?? true;
                                      },
                                    ),
                                    CircleAvatar(
                                      backgroundImage: model.locateUser.appUser
                                                  .profileImage !=
                                              null
                                          ? NetworkImage(
                                              "${model.locateUser.appUser.profileImage}")
                                          : AssetImage(
                                                  'assets/profile_icon.png')
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
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateNewGroup(),
                ),
              );
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
              Icons.arrow_circle_right_outlined,
              size: 35,
              // color: orangeColor,
            ),
          ),
        ),
      );
    });
  }
}
