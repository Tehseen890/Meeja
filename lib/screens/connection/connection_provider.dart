import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meeja/core/enums/view_state.dart';

import 'package:meeja/core/models/add_friend_model.dart';
import 'package:meeja/core/models/base_view_model.dart';
import 'package:meeja/core/models/friend_message_model.dart';

import '../../core/locator.dart';
import '../../core/services/auth_services.dart';
import '../../core/services/database_services.dart';
import 'package:intl/intl.dart';

import '../../core/services/database_storage_services.dart';

class ConnectionProvider extends BaseViewModal {
  int index = 0;
  DatabaseStorageServices _databaseStorageServices = DatabaseStorageServices();
  List<AddFriendModel> listOfFriends = [];
  DatabaseServices _databaseServices = DatabaseServices();
  FriendMessageModel friendMessageModel = FriendMessageModel();
  final locateUser = locator<AuthServices>();
  final messageController = TextEditingController();
  XFile? image;
  File? userImage;

  ConnectionProvider() {
    getFriends();
  }

  getFriends() async {
    setState(ViewState.busy);
    listOfFriends = await _databaseServices.getFriends();
    setState(ViewState.idle);
    notifyListeners();
  }

  sendMessages(
    var friendId,

    //  GroupConversationModel groupConversationModel
  ) async {
    var now = new DateTime.now();
    String formattedTime = DateFormat('h:mm a').format(now);

    friendMessageModel.sender = locateUser.appUser.appUserId.toString();
    friendMessageModel.senderName = locateUser.appUser.userName.toString();
    friendMessageModel.sentAt = formattedTime;

    await _databaseServices.sendMessage(friendMessageModel, friendId);
    messageController.clear();
    notifyListeners();

    print("Send messages");
  }

  pickImageFromGallery(friendId) async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      userImage = File(image!.path);
      // print("UserImagePath=>${userImage!.path}");
      friendMessageModel.imageUrl = await _databaseStorageServices
          .uploadMessagesImg(userImage!, locateUser.appUser.appUserId!);
      sendMessages(friendId);
      notifyListeners();
    }
  }
}
