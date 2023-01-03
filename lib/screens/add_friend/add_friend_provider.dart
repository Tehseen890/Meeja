import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeja/core/enums/view_state.dart';
import 'package:meeja/core/locator.dart';
import 'package:meeja/core/models/add_friend_model.dart';
import 'package:meeja/core/models/app_user.dart';
import 'package:meeja/core/models/base_view_model.dart';
import 'package:meeja/core/services/auth_services.dart';
import 'package:meeja/core/services/database_services.dart';

class AddFriend extends BaseViewModal {
  List<bool> checkBoxes = [];
  List<AddFriendModel> selectedUsers = [];
  final locateUser = locator<AuthServices>();
  List<AppUser> appusers = [];
  DatabaseServices _databaseServices = DatabaseServices();
  AddFriendModel addFriendModel = AddFriendModel();
  AddFriendModel currentAppUser = AddFriendModel();
  List<AddFriendModel>? listOfFriends;
  bool buttonStatus = false;

  toggleButton() {
    buttonStatus = true;
    notifyListeners();
  }

  AddFriend() {
    fetchAll_appUsers();
  }

  fetchAll_appUsers() async {
    setState(ViewState.busy);
    appusers = await _databaseServices.getAllAppUser();
    listOfFriends = await _databaseServices.getFriends();
    setState(ViewState.idle);
    notifyListeners();
  }

  addFriendStatus(String? id) {
    bool? status = false;
    listOfFriends?.forEach((element) {
      if (element.friendId == id) {
        //  print("Enter the Function<<<<<<   ${element.friendId} and ${id}");
        status = true;
      }
    });
    return status;
  }

  addfriend() async {
    try {
      setState(ViewState.busy);
      addFriendModel.addById = locateUser.appUser.appUserId;
      currentAppUser = AddFriendModel(
        friendId: locateUser.appUser.appUserId,
        friendName: locateUser.appUser.userName,
        friendImage: locateUser.appUser.profileImage,
        addById: addFriendModel.friendId,
      );
      await _databaseServices.addFriends(addFriendModel, currentAppUser);
      listOfFriends = await _databaseServices.getFriends();
      setState(ViewState.idle);
      notifyListeners();
    } catch (e) {}
  }

  changingCheckBox(int index, var getValue) {
    if (getValue == true) {
      checkBoxes[index] = getValue;
      selectedUsers.add(listOfFriends![index]);
    } else {
      checkBoxes[index] = getValue;
      selectedUsers.remove(listOfFriends?[index]);
    }

    notifyListeners();
  }
}
