import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meeja/core/models/group_conversation_model.dart';
import 'package:meeja/core/models/groups_model.dart';
import 'package:meeja/core/services/database_storage_services.dart';

import 'package:meeja/screens/widget/bottom_navigation.dart';

import '../../core/enums/view_state.dart';
import '../../core/locator.dart';
import '../../core/models/app_user.dart';
import '../../core/models/base_view_model.dart';
import '../../core/services/auth_services.dart';
import '../../core/services/database_services.dart';

class GroupProvider extends BaseViewModal {
  DatabaseServices _databaseServices = DatabaseServices();
  DatabaseStorageServices _databaseStorageServices = DatabaseStorageServices();
  List<AppUser> allAppUsers = [];
  List<AppUser> selectedUsers = [];
  List<AppUser> addMembers = [];
  List getGroupMemberList = [];
  List<AppUser> newSelectedUsers = [];
  // List<GroupModel> groups = [];
  // List<AppUser> conversationUserList = [];
  final formKey = GlobalKey<FormState>();
  List<GroupModel> getGroupList = [];
  List<GroupModel> getSelectedList = [];
  // var onlyTime = DateFormat.jm();
  XFile? image;
  File? userImage;
  List<bool> checkBoxes = [];
  List<AppUser> searchedUsers = [];
  //List GrpMember = [];

  List<GroupModel> searchedgroup = [];
  final ImagePicker imagePicker = ImagePicker();
  final messageController = TextEditingController();
  GroupModel groupModel = GroupModel();
  GroupConversationModel groupConversationModel = GroupConversationModel();

  bool isSearching = false;
  bool searching = false;
  bool isValue = false;

  Stream<QuerySnapshot>? stream;

  int selectedGroup = 0;
  //final appUser = AppUser();
  final locateUser = locator<AuthServices>();

  GroupProvider() {
    getAppUsers();
    getGroups();

    // getGroupInfo();

    // getselectedUser();

    // createGroupName();
  }
////////////////creation of group///////////
  ///
  ///
  createGroup(
    BuildContext context,
  ) async {
    setState(ViewState.busy);
    // extract user ids from selected user list
    List<String?> membersListUserIds = selectedUsers.map(
      (
        AppUser user,
      ) {
        return user.appUserId;
//return grpMember(user.appUserId,user.userName);
      },
    ).toList();
    //add admin to mebers list as well
    membersListUserIds.add(locateUser.appUser.appUserId);

    print(membersListUserIds);

    List<String> memberListNames = selectedUsers.map((AppUser user) {
      return user.userName!;
    }).toList();
    memberListNames.add(locateUser.appUser.userName!);
    print(memberListNames);

    GroupModel x = GroupModel(
      groupAdmin: locateUser.appUser.appUserId,
      members: membersListUserIds,
      groupName: groupModel.groupName,
      memberName: memberListNames,
    );

    final result = await _databaseServices.createGroup(x);

    if (result != true) {
      // customSnackBar(context, "Could not send Request");
      print("enter group name");
    } else {
      // await Future.delayed(Duration(seconds: 2));
      print('INSIDE ELSE BLOCK');
      // selectedGroup = getGroupList.indexOf(x);
      // print(getGroupList.indexOf(x));

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => BottomNavigation(
            indexValue: 2,
          ),
          // builder: (context) => ChatScreen(
          //       getGroup: getGroupList[selectedGroup],
          //     )
        ),
        (Route<dynamic> route) => false,
      );
      // if (getGroupList.contains(x)) {
      //   print("Group name is-------- ");
      //   //get group index
      //   int i = getGroupList.indexOf(x);

      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => ChatScreen(
      //         getGroup: getGroupList[i],
      //       ),
      //     ),
      //   );
      // }
      clearResources();
      intializingCheckBoxes();
    }

    setState(ViewState.idle);
  }

  intializingCheckBoxes() {
    checkBoxes = [];
    for (int i = 0; i < allAppUsers.length; i++) {
      checkBoxes.add(false);
    }
    notifyListeners();
  }

///////////////////////get groups///////////////////
  ///
  ///

  getGroups() async {
    setState(ViewState.busy);
    stream = await _databaseServices.getCreateGroup();

    await stream!.listen((event) {
      if (event.docs.length > 0) {
        // print('Stream step 01');

        getGroupList = [];
        event.docs.forEach((element) {
          getGroupMemberList = element['members'];

          print(getGroupMemberList.toString() + "================>");

          // print('Stream step 02');
          if (getGroupMemberList.contains(locateUser.appUser.appUserId)) {
            // print("Stream is updating");
            // print('Stream step 03');
            getGroupList.add(GroupModel.formJson(element, element.id));

            for (int i = 0; i < getGroupList.length; i++) {
              print(
                  'element[i]:\n${getGroupList[i].members}'); // getGroupMemberList.add(GroupModel.formJson(element, element.id));

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
    setState(ViewState.idle);
  }

/////////////getmember///////////////////
  ///
  ///
  // getGroupInfo() {
  //   for (int i = 0; i < allAppUsers.length; i++) {
  //     if (allAppUsers[i].appUserId == groupModel.members![i]) {
  //       print("members are=====================================>");
  //     }
  //   }
  // }

///////////////////////////update groups/////////////////////
  ///
  ///
  updateGroups() async {
    setState(ViewState.busy);

    // List<String?> membersListUserIds = addMembers.map(
    //   (
    //     AppUser user,
    //   ) {
    //     return user.appUserId;
    //   },
    // ).toList();

    // print("${membersListUserIds}");
    print("${getGroupList[selectedGroup].groupId}");
    print("${getGroupList[selectedGroup].groupName}");

    await _databaseServices.updateGroup(getGroupList[selectedGroup]);
    clearResources();
    intializingCheckBoxes();

    setState(ViewState.idle);
  }

//////////////////////getselectedUser//////////////////
  ///
  ///
  ///
  ///
  ///

  // getselectedUser() async {
  //   stream = _databaseServices.getSelectedUserr();

  //   stream!.listen((event) {
  //     if (event.docs.length > 0) {
  //       print("Event length :: " + event.docs.length.toString());

  //       getSelectedList = [];
  //       event.docs.forEach((element) {
  //         getSelectedList.add(GroupModel.formJson(element, element.id));

  //         notifyListeners();
  //         print(element.id.toString());
  //       });

  //       print("selected usersss  " + getSelectedList[0].members.toString());
  //     }
  //   });
  // }
  /////////////////////////get appuser////////////////

  getAppUsers() async {
    setState(ViewState.busy);
    allAppUsers = await _databaseServices.getAllAppUser();
    intializingCheckBoxes();

    print("$allAppUsers");
    setState(ViewState.idle);
  }

//////////////sending messsage /////////////////////////////
  sendMessages(
    var groupId,

    //  GroupConversationModel groupConversationModel
  ) async {
    if (formKey.currentState!.validate()) {
      var now = new DateTime.now();
      String formattedTime = DateFormat('h:mm a').format(now);
      setState(ViewState.busy);

      groupConversationModel.sender = locateUser.appUser.appUserId.toString();
      groupConversationModel.senderName =
          locateUser.appUser.userName.toString();
      groupConversationModel.sentAt = formattedTime;

      await _databaseServices.sendGroupMessage(groupConversationModel, groupId);
      messageController.clear();

      notifyListeners();

      print("Send messages");
      setState(ViewState.idle);
    } else {
      print("Send cannot be messages");
    }
  }

  changingCheckBox(int index, var getValue) {
    if (getValue == true) {
      checkBoxes[index] = getValue;
      selectedUsers.add(allAppUsers[index]);
    } else {
      checkBoxes[index] = getValue;
      selectedUsers.remove(allAppUsers[index]);
    }

    notifyListeners();
  }
//////////////////////////////adding member/////////////////
  ///
  ///

  addingMember(int index, getValue) {
    if (getValue == true) {
      checkBoxes[index] = getValue;
      addMembers.add(allAppUsers[index]);
    } else {
      checkBoxes[index] = getValue;
      addMembers.remove(allAppUsers[index]);
    }

    notifyListeners();
  }

  // selectedUsersFun(){

  //   checkBoxes.contains(true);
  // }

  pickImageFromGallery(groupId) async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      userImage = File(image!.path);
      // print("UserImagePath=>${userImage!.path}");
      groupConversationModel.imageUrl = await _databaseStorageServices
          .uploadMessagesImg(userImage!, locateUser.appUser.appUserId!);
      sendMessages(groupId);
      notifyListeners();
    }
  }

  ///
  /// search user by name
  ///
  searchUserByName(String keyword) {
    print("Searched keyword : $keyword");
    keyword.isEmpty ? isSearching = false : isSearching = true;
    searchedUsers = allAppUsers
        .where(
            (e) => (e.fullName!.toLowerCase().contains(keyword.toLowerCase())))
        .toList();

    searchedUsers = allAppUsers
        .where(
            (e) => (e.fullName!.toLowerCase().contains(keyword.toLowerCase())))
        .toList();

    notifyListeners();
  }

//////////////////////////////////////newList getUser//////////////////////////////
  // getNewList(int index) {
  //   allAppUsers.contains(getSelectedList);
  //   for (int i = 0; i < getSelectedList.length; i++) {
  //     newSelectedUsers.add(allAppUsers[index]);
  //   }
  // }

////////////search group by name////////////////

  searchGroypByName(String keyword) {
    print("Searched keyword : $keyword");
    keyword.isEmpty ? searching = false : searching = true;
    searchedgroup = getGroupList
        .where(
            (e) => (e.groupName!.toLowerCase().contains(keyword.toLowerCase())))
        .toList();

    searchedgroup = getGroupList
        .where(
            (e) => (e.groupName!.toLowerCase().contains(keyword.toLowerCase())))
        .toList();

    notifyListeners();
  }

  // getSelectedUser(var getUser) {
  //   selectedUser = getUser;
  //   notifyListeners();
  // }

  bool get isChecked => isValue;
  set isChecked(bool Value) {
    isValue = Value;
    notifyListeners();
  }

//Trigger this funciton on group creation
  clearResources() {
    selectedUsers.clear();
    messageController.clear;
    notifyListeners();
  }
}
