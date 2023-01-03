import 'package:flutter/material.dart';
import 'package:meeja/core/constants/colors.dart';
import 'package:meeja/core/enums/view_state.dart';

import 'package:meeja/screens/add_friend/add_friend_provider.dart';
import 'package:meeja/screens/connection/connection_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:provider/provider.dart';

import '../widget/customFriends.dart';

class AddFriendScreen extends StatefulWidget {
  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddFriend(),
      child: Consumer<AddFriend>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "Add Friend",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: ModalProgressHUD(
              progressIndicator: CircularProgressIndicator(color: orangeColor),
              inAsyncCall: model.state == ViewState.busy,
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 8,
                    ),

                    ListView.builder(
                      itemCount: model.appusers.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 16),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CustomFriend(
                          title: model.appusers[index].fullName,
                          image1: model.appusers[index].profileImage == null
                              ? 'assets/profile_icon.png'
                              : model.appusers[index].profileImage,
                          onpress: () async {
                            model.addFriendModel.friendName =
                                model.appusers[index].fullName;
                            model.addFriendModel.friendId =
                                model.appusers[index].appUserId;
                            model.addFriendModel.friendImage =
                                model.appusers[index].profileImage;

                            await model.addfriend();
                            // final status = model
                            //     .addFriendStatus(model.appusers[index].appUserId);
                            //    model.toggleButton();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text(
                                    '${model.addFriendModel.friendName}   added as friend'),
                              ),
                            );
                            Provider.of<ConnectionProvider>(context,
                                    listen: false)
                                .getFriends();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => AddFriendScreen()));
                          },
                          isAdded: model.appusers[index].appUserId,
                          model: model,
                          // friendId: model.listOfFriends.forEach((element) {
                          //   if (element.friendId ==
                          //       model.appusers[index].appUserId) {

                          //   }
                          //   return;
                          // }),
                        );
                      },
                    ),
                    // SizedBox(height: 20),
                  ],
                ),
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
