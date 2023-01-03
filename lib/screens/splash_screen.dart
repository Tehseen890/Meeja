import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meeja/core/constants/colors.dart';

import 'package:meeja/screens/authentication/signup_screen.dart';
import 'package:meeja/screens/widget/bottom_navigation.dart';
import 'package:get/get.dart';

import '../core/locator.dart';
import '../core/services/auth_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authService = locator<AuthServices>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreenDelay();
  }

  splashScreenDelay() async {
    ///
    /// splash screen delay
    ///
    await Future.delayed(Duration(seconds: 3));

    if (_authService.appUser.appUserId != null && _authService.isLogin!) {
      if (_authService.appUser.isFirstLogin ?? false) {
        Get.offAll(
          () => BottomNavigation(indexValue: 0),
        );
      } else {
        Get.offAll(() => BottomNavigation(
              indexValue: 0,
            ));
        print('User id=> ${_authService.appUser.appUserId}');
        Future.delayed(Duration(seconds: 1));
        // Get.snackbar("Congrats", "message",snackStyle: SnackStyle.FLOATING,isDismissible: true);
      }
    } else if (_authService.appUser == null && !_authService.isLogin!) {
      Get.offAll(() => SignUp());
      print("App user name ${_authService.appUser.userName}");
      print("isLogin ${_authService.isLogin}");
    } else {
      Get.offAll(() => SignUp());
      print("User email ${_authService.appUser.userEmail}");
      print("isLogin ${_authService.isLogin}");
    }

    // Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: orangeColor,
      body: Center(
          child: Container(
        child: SvgPicture.asset(
          "assets/logo.svg",
        ),
      )),
    );
  }
}
