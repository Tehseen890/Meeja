import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meeja/core/models/base_view_model.dart';
import 'package:meeja/screens/widget/custom_snackbar.dart';

import '../../core/enums/view_state.dart';
import '../../core/locator.dart';
import '../../core/models/app_user.dart';
import '../../core/services/auth_services.dart';
import '../../core/services/custom_auth_result.dart';
import '../../core/services/database_services.dart';
import '../../core/services/database_storage_services.dart';
import '../widget/bottom_navigation.dart';

// class AuthenticationProvider with BaseViewModal {
//   bool isValue = false;

//   bool get isChecked => isValue;

//   set isChecked(bool value) {
//     isValue = value;
//     notifyListeners();
//   }
// }

class AuthenticationProvider extends BaseViewModal {
  XFile? image;
  File? userImage;
  DatabaseStorageServices databaseStorageServices = DatabaseStorageServices();
  DatabaseServices databaseServices = DatabaseServices();

  final locateUser = locator<AuthServices>();

  String? imageUrl;
  final ImagePicker imagePicker = ImagePicker();
  bool isValue = false;
  AuthenticationProvider() {
    print("AuthenticationPRovider built");
  }
  bool get isChecked => isValue;
  set isChecked(bool value) {
    isValue = value;
    notifyListeners();
  }

  var renderScreen = 0;
  DateTime selectedDate = DateTime.now();
  var selectedDateString;
  var forgotPasswordEmail;
  var checkingText = "HEllo there";
  var emailSendingMsg;

  final _authServices = locator<AuthServices>();
  CustomAuthResult customAuthResult = CustomAuthResult();
  AppUser appUser = AppUser();
  final formKey = GlobalKey<FormState>();

  void changeDateFun(var d) {
    print("here is also printint" + d.toString());
    selectedDate = d;

    print("here is Selected " + selectedDate.toString());
    //selectedDateString = DateFormat.yMMMMd("en_US").format(selectedDate).toString();
    notifyListeners();
  }

  void renderScreenFun(int getRenderScreen) {
    renderScreen = getRenderScreen;

    notifyListeners();
  }

  void checkingFun(var getText) {
    checkingText = getText;
    notifyListeners();
  }

  ///
  ///
  /// Reset Password

  resetPassword(String email) async {
    if (email != null) {
      print('Reset User password Email=>${appUser.userEmail}');
      await _authServices.resetUserPassword(email);
    } else {
      print("hellllllllooo");
    }
  }

  void updateEmailSendingMsgFun(var email) {
    emailSendingMsg = "Email has been sent to " +
        "$email" +
        "please check your spam if you have not received";
    notifyListeners();
  }

  ///
  signUpUser(AppUser appUser, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      print("User Name: ${appUser.userName}");
      print("User Email: ${appUser.userEmail}");
      print("User Password: ${appUser.password}");
      //
      appUser.isFirstLogin = true;
      setState(ViewState.busy);
      appUser.createdAt = DateTime.now();
      appUser.lastEntry = DateTime.now();

      //appUser.monthYear = monthYear.format(DateTime.now());
      ///
      customAuthResult = await _authServices.signUpUser(appUser, userImage);
      setState(ViewState.idle);

      if (customAuthResult.user != null) {
        print("SignUpUserId=> ${_authServices.appUser.appUserId}");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BottomNavigation(
                    indexValue: 0,
                  )),
        );
        // Navigator.pushReplacement(
        //   context, CustomPageRoute(child: BottomNavigation()));
      } else {
        print(customAuthResult.errorMessage.toString());
        customSnackBar(
          context,
          "${customAuthResult.errorMessage}",
          // behavior: SnackBarBehavior.fixed,
        );
      }
    } else {
      print("not showing true");
    }
    //
  }

  pickImageFromGallery() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      userImage = File(image!.path);
      // print("UserImagePath=>${userImage!.path}");
      notifyListeners();
    }
  }

  ///

  loginUser(BuildContext context) async {
    try {
      if (formKey.currentState!.validate()) {
        print("App user email: ${appUser.userEmail}");
        print("App user Password: ${appUser.password}");
        setState(ViewState.busy);
        customAuthResult = await _authServices.loginUser(appUser);

        setState(ViewState.idle);

        if (customAuthResult.status!) {
          print("App user Id: ${_authServices.appUser.appUserId}");
          print("Is first Login=> ${_authServices.appUser.isFirstLogin}");
          if (_authServices.appUser.isFirstLogin == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavigation(
                        indexValue: 0,
                      )),
            );
            // Navigator.pushReplacement(
            //   context, CustomPageRoute(child: BottomNavigation()));
          } else if (_authServices.appUser.isFirstLogin == false) {
            //
          }
        } else {
          //      }
          customSnackBar(
            context,
            "${customAuthResult.errorMessage}",
            // behavior: SnackBarBehavior.fixed,
          );
        }
      }
    } catch (e) {
      customSnackBar(
        context,
        "${e}",
        // behavior: SnackBarBehavior.fixed,
      );
      print(e);
    }
  }
}
