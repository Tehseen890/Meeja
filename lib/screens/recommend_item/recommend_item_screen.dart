import 'package:flutter/material.dart';
import 'package:meeja/screens/connection/friend_chat_screen.dart';

import 'package:meeja/screens/groups/chat_screen.dart';
import 'package:meeja/screens/recommend_item/recommended_item_provider.dart';
import 'package:meeja/screens/widget/custom_Recommended.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../widget/custom_appBar.dart';
import '../widget/sub_button.dart';

class RecommendedItem extends StatelessWidget {
  var results;
  RecommendedItem(this.results);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecommendedItemProvider(),
      child: Consumer<RecommendedItemProvider>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: CustomAppBar(
              title: Center(
                child: Text(
                  "Recommended Item",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    child: TextFormField(
                      onChanged: (value) async {
                        model.index != 0
                            ? model.searchGroupByName(value)
                            : model.searchUserByName(value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        contentPadding: EdgeInsets.all(10.0),
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search Here",
                        hintStyle:
                            TextStyle(color: Color.fromARGB(115, 46, 46, 46)),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SubButton(
                        onpress: () {
                          model.changeActiveColor(0);
                        },
                        BText: "Chats",
                        style: TextStyle(
                            color:
                                model.index == 0 ? Colors.white : Colors.black),
                        color:
                            model.index == 0 ? orangeColor : Color(0xffFEF6F5),
                      ),
                      SubButton(
                        onpress: () {
                          model.changeActiveColor(1);
                        },
                        BText: "Groups",
                        style: TextStyle(
                            color:
                                model.index == 1 ? Colors.white : Colors.black),
                        color:
                            model.index == 1 ? orangeColor : Color(0xffFEF6F5),
                      )
                    ],
                  ),

                  model.listOfFriends.isEmpty
                      ? Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                            Text('No Friends yet'),
                          ],
                        )
                      : model.index == 0
                          ? ListView.builder(
                              itemCount: model.isSearching == false
                                  ? model.listOfFriends.length
                                  : model.searchedUsers.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 16),
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                print('enter');
                                return CustomRecommended(
                                  title: model.isSearching == false
                                      ? model.listOfFriends[index].friendName
                                      : model.searchedUsers[index].friendName,
                                  image1: model.isSearching == false
                                      ? model.listOfFriends[index]
                                                  .friendImage ==
                                              null
                                          ? 'assets/profile_icon.png'
                                          : model
                                              .listOfFriends[index].friendImage
                                      : model.searchedUsers[index]
                                                  .friendImage ==
                                              null
                                          ? 'assets/profile_icon.png'
                                          : model
                                              .searchedUsers[index].friendImage,
                                  onpress: () async {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('${results.title}     send'),
                                      ),
                                    );
                                    model.friendMessageModel.messageText =
                                        results.title;
                                    await model.sendFriendMessages(model
                                            .searchedUsers.isEmpty
                                        ? model.listOfFriends[index].friendId
                                        : model.searchedUsers[index].friendId);

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FriendChatScreen(
                                                  fieldText: results.title,
                                                  friendId: model.isSearching ==
                                                          false
                                                      ? model
                                                          .listOfFriends[index]
                                                          .friendId
                                                      : model
                                                          .searchedUsers[index]
                                                          .friendId,
                                                )));
                                  },
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: model.isSearching == false
                                  ? model.getGroupList.length
                                  : model.searchedGroupUsers.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 16),
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                print('enter');
                                print(model.getGroupList[index].groupName);
                                return CustomRecommended(
                                  title: model.isSearching == false
                                      ? model.getGroupList[index].groupName
                                      : model
                                          .searchedGroupUsers[index].groupName,
                                  image1: 'assets/profile_icon.png',
                                  onpress: () async {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('${results.title}     send'),
                                      ),
                                    );
                                    model.groupConversationModel.messageText =
                                        results.title;
                                    await model.sendMessages(
                                      model.searchedGroupUsers.isEmpty
                                          ? model.getGroupList[index].groupId
                                          : model.searchedGroupUsers[index]
                                              .groupId,
                                    );
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ChatScreen(
                                                  fieldText: results.title,
                                                  groupId: model.isSearching ==
                                                          false
                                                      ? model
                                                          .getGroupList[index]
                                                          .groupId
                                                      : model
                                                          .searchedGroupUsers[
                                                              index]
                                                          .groupId,
                                                )));
                                  },
                                );
                              },
                            ),
                  // SizedBox(height: 20),
                ],
              ),
            ),

            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.miniCenterDocked,
          );
        },
      ),
    );
  }
}
