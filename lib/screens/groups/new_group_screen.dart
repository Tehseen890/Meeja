import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meeja/core/constants/colors.dart';
import 'package:meeja/screens/widget/custom_textfield.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:provider/provider.dart';

import '../../core/enums/view_state.dart';
import '../../core/models/groups_model.dart';
import 'chat_screen.dart';
import 'group_provider.dart';

class CreateNewGroup extends StatelessWidget {
  GroupModel? getGroup;

  CreateNewGroup({this.getGroup});

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
                'Create New Group',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          body: ModalProgressHUD(
            progressIndicator: CircularProgressIndicator(
              color: orangeColor,
            ),
            inAsyncCall: model.state == ViewState.busy,
            child: SingleChildScrollView(
              child: Container(
                child: Form(
                  key: model.formKey,
                  child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            "assets/logo1.svg",
                            color: orangeColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SvgPicture.asset("assets/logo2.svg"),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: customTextField(
                            text: " Group Name",
                            hinttext: "Enter Group Name",
                            onChanged: (value) {
                              model.groupModel.groupName = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          color: orangeColor,
                          height: 50,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Participants",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 100,
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
                                          : AssetImage(
                                                  'assets/profile_icon.png')
                                              as ImageProvider,
                                      radius: 25,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(model.selectedUsers[index].userName
                                        .toString()),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              model.createGroup(context);

              //get group index
              // int i = model.getGroupList.indexOf(getGroup!);
              // print("Group name is-------- ");
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ChatScreen(
              //       getGroup: model.getGroupList[i],
              //     ),
              //   ),
              // );
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
