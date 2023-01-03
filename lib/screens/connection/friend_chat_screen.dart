import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meeja/core/constants/colors.dart';
import 'package:meeja/screens/connection/connection_provider.dart';

import 'package:provider/provider.dart';

class FriendChatScreen extends StatelessWidget {
  var fieldText;
  String? friendId;
  FriendChatScreen({this.fieldText, this.friendId});
  final messageController = TextEditingController();
  @override
  void initState() {
    messageController.text = fieldText;
    print("object");
    print(messageController.text);
  }

  // GroupModel? getGroup;
  // ChatScreen({this.getGroup});
  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectionProvider>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              //  model.selectedGroup = 0;
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
          title: GestureDetector(
            onTap: () {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => GroupInfo()),
              // );
            },
            child: Center(
                child: Text(
              model.listOfFriends
                  .firstWhere((element) => element.friendId == friendId)
                  .friendName
                  .toString(),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )),
          ),
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
        body: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Conversation")
                      .doc(model.locateUser.appUser.appUserId)
                      .collection("Chats")
                      .doc(friendId)
                      .collection("Messages")
                      .orderBy('sentAt', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      // print(snapshot.data!.docs["messageText"]);
                      // return Text('message');

                      return // Expanded(
                          ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        reverse: true,

                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          DocumentSnapshot doc = snapshot.data!.docs[index];

                          // return ChatBubble();

                          return Align(
                            alignment: (doc["sender"] ==
                                    model.locateUser.appUser.appUserId
                                ? Alignment.topRight
                                : Alignment.topLeft),
                            child: Container(
                              // color: Colors.amber,
                              child: Column(
                                crossAxisAlignment: (doc["sender"] ==
                                        model.locateUser.appUser.appUserId
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18, right: 100),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: (doc["sender"] ==
                                              model.locateUser.appUser.appUserId
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start),
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: model.locateUser
                                                      .appUser.profileImage !=
                                                  null
                                              ? NetworkImage(
                                                  "${model.locateUser.appUser.profileImage}")
                                              : AssetImage(
                                                      'assets/profile_icon.png')
                                                  as ImageProvider,
                                          radius: 10,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "${doc['senderName']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 14,
                                        right: 14,
                                        top: 10,
                                        bottom: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: doc["sender"] ==
                                                model.locateUser.appUser
                                                    .appUserId
                                            ? BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                bottomLeft: Radius.circular(30),
                                                bottomRight:
                                                    Radius.circular(30),
                                              )
                                            : BorderRadius.only(
                                                topRight: Radius.circular(30),
                                                bottomLeft: Radius.circular(30),
                                                bottomRight:
                                                    Radius.circular(30),
                                              ),
                                        color: (doc["sender"] ==
                                                model.locateUser.appUser
                                                    .appUserId
                                            ? orangeColor
                                            : Color(0xffC4C4C4)),
                                      ),
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          doc['imageUrl'] != null
                                              ? Image.network(
                                                  '${doc['imageUrl']}')
                                              : Text(
                                                  "${doc['messageText']}",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: (doc["sender"] ==
                                                            model
                                                                .locateUser
                                                                .appUser
                                                                .appUserId
                                                        ? Colors.white
                                                        : Colors.black),
                                                  ),
                                                ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "${doc['sentAt']}",
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: (doc["sender"] ==
                                                        model.locateUser.appUser
                                                            .appUserId
                                                    ? Colors.white
                                                    : Colors.black)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Text("No Messages found");
                    }
                  }),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Form(
                  //  key: model.formKey,
                  child: TextFormField(
                      //  initialValue: fieldText,
                      onChanged: (value) {
                        model.friendMessageModel.messageText = value;
                      },
                      cursorColor: orangeColor,
                      controller: model.messageController,
                      decoration: InputDecoration(
                        hintText: "Message",
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              // model.groupConversationModel.messageText =
                              //     messageController.text;

                              model.sendMessages(friendId);
                            },
                            child: Icon(
                              Icons.send,
                              color: orangeColor,
                              size: 30,
                            ),
                          ),
                        ),
                        prefixIcon: GestureDetector(
                          onTap: () {
                            model.pickImageFromGallery(friendId);
                          },
                          child: Icon(
                            Icons.photo_camera_outlined,
                            size: 30,
                            color: orangeColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey)),
                      )),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
