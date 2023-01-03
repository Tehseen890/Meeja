import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meeja/core/models/add_friend_model.dart';

import 'package:intl/intl.dart';
import '../../core/locator.dart';
import '../../core/models/friend_message_model.dart';
import '../../core/models/group_conversation_model.dart';
import '../../core/models/groups_model.dart';
import '../../core/services/auth_services.dart';
import '../../core/services/database_services.dart';
import '../add_friend/add_friend_provider.dart';

class RecommendedItemProvider extends ChangeNotifier {
  List getGroupMemberList = [];
  List<GroupModel> getGroupList = [];
  Stream<QuerySnapshot>? stream;
  final locateFriend = locator<AddFriend>();
  final locateUser = locator<AuthServices>();
  FriendMessageModel friendMessageModel = FriendMessageModel();
  int index = 0;
  List<AddFriendModel> listOfFriends = [];
  DatabaseServices _databaseServices = DatabaseServices();

  bool isSearching = false;
  List<AddFriendModel> searchedUsers = [];
  List<GroupModel> searchedGroupUsers = [];

  GroupConversationModel groupConversationModel = GroupConversationModel();

  RecommendedItemProvider() {
    //this.listOfFriends = locateUser.listOfFriends;
    getFriends();
    getGroups();
  }

  changeActiveColor(int x) {
    index = x;
    notifyListeners();
  }

  getFriends() async {
    listOfFriends = await _databaseServices.getFriends();

    notifyListeners();
  }

  getGroups() async {
    stream = await _databaseServices.getCreateGroup();

    stream!.listen((event) {
      if (event.docs.length > 0) {
        // print('Stream step 01');
        //getGroupMemberList = [];

        getGroupList = [];
        event.docs.forEach((element) {
          getGroupMemberList = element['members'];

          // print(getGroupMemberList.toString() + "================>");

          // print('Stream step 02');
          if (getGroupMemberList.contains(locateUser.appUser.appUserId)) {
            // print("Stream is updating");
            // print('Stream step 03');
            getGroupList.add(GroupModel.formJson(element, element.id));

            for (int i = 0; i < getGroupList.length; i++) {
              //   print(
              //     'element[i]:\n${getGroupList[i].members}'); // getGroupMemberList.add(GroupModel.formJson(element, element.id));

            }
            // print(
            //     "second last element=====>${getGroupList.elementAt(getGroupList.length - 1).members}");

          } else {
            print("this is is not added to any group");
          }

          notifyListeners();
        });
      }
    });
  }

  ///
  /// search user by name
  ///
  searchUserByName(String keyword) {
    //  print("Searched keyword : $keyword");
    keyword.isEmpty ? isSearching = false : isSearching = true;
    searchedUsers = listOfFriends
        .where((e) =>
            (e.friendName!.toLowerCase().contains(keyword.toLowerCase())))
        .toList();

    searchedUsers = listOfFriends
        .where((e) =>
            (e.friendName!.toLowerCase().contains(keyword.toLowerCase())))
        .toList();

    notifyListeners();
  }

  searchGroupByName(String keyword) {
    // print("Searched keyword : $keyword");
    keyword.isEmpty ? isSearching = false : isSearching = true;
    searchedGroupUsers = getGroupList
        .where(
            (e) => (e.groupName!.toLowerCase().contains(keyword.toLowerCase())))
        .toList();

    searchedGroupUsers = getGroupList
        .where(
            (e) => (e.groupName!.toLowerCase().contains(keyword.toLowerCase())))
        .toList();

    notifyListeners();
  }

  //////////////sending messsage /////////////////////////////
  sendMessages(
    var groupId,

    //  GroupConversationModel groupConversationModel
  ) async {
    var now = new DateTime.now();
    String formattedTime = DateFormat('h:mm a').format(now);
    print("<<<<<<<<<<object>>>>>>>>>>");
    // print(searchedGroupUsers.length);

    groupConversationModel.sender = locateUser.appUser.appUserId.toString();
    groupConversationModel.senderName = locateUser.appUser.userName.toString();
    groupConversationModel.sentAt = formattedTime;

    await _databaseServices.sendGroupMessage(groupConversationModel, groupId);

    notifyListeners();

    print("Send messages");
  }

  sendFriendMessages(
    var friendId,

    //  GroupConversationModel groupConversationModel
  ) async {
    print("hy thereee");
    print(friendMessageModel.messageText);
    var now = new DateTime.now();
    String formattedTime = DateFormat('h:mm a').format(now);

    friendMessageModel.sender = locateUser.appUser.appUserId.toString();
    friendMessageModel.senderName = locateUser.appUser.userName.toString();
    friendMessageModel.sentAt = formattedTime;

    await _databaseServices.sendMessage(friendMessageModel, friendId);

    notifyListeners();

    print("Send messages");
  }
}
