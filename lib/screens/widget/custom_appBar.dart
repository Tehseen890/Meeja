import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// A CustomAppBar for this application, which will display
  /// the app logo by default as its title widget
  /// modify it as per need
  static final _appBar = AppBar();
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  final bool backButton;
  final Widget? title;
  const CustomAppBar({
    Key? key,
    this.backButton = false,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(90.0),
      child: AppBar(
        elevation: 0,
        // leading: !backButton
        //     ? SizedBox()
        //     : GestureDetector(
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //         child: CircleAvatar(
        //           backgroundColor: Colors.white,
        //           radius: 5,
        //           child: Icon(
        //             Icons.arrow_back,
        //             color: Colors.black,
        //             size: 20,
        //           ),
        //         ),
        //       ),
        backgroundColor:
            //Colors.black,
            Color(0xffFEF6F5),
        title: Center(
          child: title ??
              SvgPicture.asset(
                "assets/Group.svg",
                color: orangeColor,
              ),
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
    );
  }
}
