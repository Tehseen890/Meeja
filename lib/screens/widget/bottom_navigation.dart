import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meeja/core/constants/colors.dart';

import '../groups/allchat_screen.dart';
import '../connection/connection_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../search/search_screen.dart';

class BottomNavigation extends StatefulWidget {
  int? indexValue;
  BottomNavigation({required this.indexValue});
  @override
  _BottomNavigationState createState() => _BottomNavigationState(indexValue!);
}

class _BottomNavigationState extends State<BottomNavigation> {
  int indexValue;

  _BottomNavigationState(this.indexValue);
  final pages = [
    HomeScreen(),
    SearchScreen(),
    AllChatScreen(),
    ConnectionScreen(),
    ProfileScreen(),
  ];

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: orangeColor,
                  // Background color
                ),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: orangeColor,
                  // Background color
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        // backgroundColor: pageIndex == 0 ? Colors.white : blackColor,
        body: pages[indexValue],
        bottomNavigationBar: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Color(0xffFEF6F5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BottomNavigationItems(
                getColor: indexValue == 0 ? orangeColor : Color(0xff968E8C),
                iconPath: 'assets/home.svg',
                onPressed: () {
                  setState(() {
                    indexValue = 0;
                  });
                },
              ),
              BottomNavigationItems(
                getColor: indexValue == 1 ? orangeColor : Color(0xff968E8C),
                iconPath: 'assets/search.svg',
                onPressed: () {
                  setState(() {
                    indexValue = 1;
                  });
                },
              ),
              BottomNavigationItems(
                getColor: indexValue == 2 ? orangeColor : Color(0xff968E8C),
                iconPath: 'assets/chat.svg',
                onPressed: () {
                  setState(() {
                    indexValue = 2;
                  });
                },
              ),
              BottomNavigationItems(
                getColor: indexValue == 3 ? orangeColor : Color(0xff968E8C),
                iconPath: 'assets/connection.svg',
                onPressed: () {
                  setState(() {
                    indexValue = 3;
                  });
                },
              ),
              BottomNavigationItems(
                getColor: indexValue == 4 ? orangeColor : Color(0xff968E8C),
                iconPath: 'assets/profile.svg',
                onPressed: () {
                  setState(() {
                    indexValue = 4;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavigationItems extends StatelessWidget {
  final iconPath;
  final onPressed;
  final getColor;

  BottomNavigationItems({
    this.iconPath,
    this.onPressed,
    this.getColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            color: getColor,
            height: 40,
          ),
        ],
      ),
    );
  }
}
