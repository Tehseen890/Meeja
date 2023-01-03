import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeja/core/constants/colors.dart';
import 'package:meeja/core/enums/view_state.dart';

import 'package:meeja/screens/groups/chat_screen.dart';
import 'package:meeja/screens/groups/create_group_screen.dart';
import 'package:meeja/screens/groups/group_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../widget/custom_appBar.dart';
import '../widget/custom_floating_button.dart';

class AllChatScreen extends StatelessWidget {
  AllChatScreen() {
    print("object");
  }
  //final locateUser = locator<AuthServices>();
  // List<GroupModel> groupList = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: Center(
              child: Text(
                "All Chats",
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
            child: Column(children: [
              Container(
                margin:
                    REdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  decoration: InputDecoration(
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
              model.searching == false
                  ?
                  // ? model.getGroupList.isEmpty
                  //     ? Column(
                  //         children: [
                  //           SizedBox(
                  //             height: MediaQuery.of(context).size.height * 0.3,
                  //           ),
                  //           Text("No Groups"),
                  //         ],
                  //       )
                  //     :
                  Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: model.searching == false
                                  ? model.getGroupList.length
                                  : model.searchedgroup.length,
                              itemBuilder: (context, index) {
                                // var getimg = doc["imageUrl"];
                                // print('print type' + type.toString());
                                return InkWell(
                                  onTap: () {
                                    model.selectedGroup = index;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                            // getGroup: model.getGroupList[index],
                                            ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 10, left: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundImage:
                                              AssetImage('assets/img7.png'),
                                          radius: 25.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            model.getGroupList[index].groupName
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen()));
                      },
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: model.isSearching == false
                              ? model.getGroupList.length
                              : model.searchedgroup.length,
                          itemBuilder: (context, index) {
                            // var getimg = doc["imageUrl"];
                            // print('print type' + type.toString());
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 10, left: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage('assets/img7.png'),
                                    radius: 25.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      model.searchedgroup[index].groupName
                                          .toString(),
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
                          }),
                    ),
            ]),
          ),
          floatingActionButton: CustomFAB(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateGroup()),
              );
            },
          ),
        );
      },
    );
  }
}
