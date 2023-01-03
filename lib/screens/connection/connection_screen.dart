import 'package:flutter/material.dart';
import 'package:meeja/core/constants/colors.dart';
import 'package:meeja/core/enums/view_state.dart';

import 'package:meeja/screens/add_friend/add_friend_screen.dart';
import 'package:meeja/screens/connection/friend_chat_screen.dart';

import 'package:meeja/screens/widget/custom_connection.dart';
import 'package:meeja/screens/widget/custom_floating_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:provider/provider.dart';

import '../widget/custom_appBar.dart';

import 'connection_provider.dart';

class ConnectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConnectionProvider(),
      child: Consumer<ConnectionProvider>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: CustomAppBar(
              title: Center(
                child: Text(
                  "Connections",
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
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 8,
                    ),

                    model.listOfFriends.isEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                              ),
                              Center(child: Text('No Friends yet')),
                            ],
                          )
                        : ListView.builder(
                            itemCount: model.listOfFriends.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 16),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              print('object');
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => FriendChatScreen(
                                            friendId: model
                                                .listOfFriends[index].friendId,
                                          )));
                                },
                                child: CustomConnection(
                                  title: model.listOfFriends[index].friendName,
                                  image1: model.listOfFriends[index]
                                              .friendImage ==
                                          null
                                      ? 'assets/profile_icon.png'
                                      : model.listOfFriends[index].friendImage,
                                ),
                              );
                            },
                          ),
                    // SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            floatingActionButton: Container(
              margin: EdgeInsets.only(bottom: 20, right: 20),
              child: CustomFAB(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddFriendScreen()));
                },
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
