import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:meeja/core/constants/colors.dart';
import 'package:meeja/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import '../widget/customExpansionTile.dart';
import '../widget/custom_button.dart';
import 'profile_provider.dart';
// import '../widget/custom_expandablelistview.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProfileProvider(),
        child: Consumer<ProfileProvider>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color(0xffFEF6F5),
              title: Center(
                  child: Text(
                "          Profile       ",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 10),
                    child: CircleAvatar(
                      backgroundColor: Color(0xffE7DEDC),
                      backgroundImage: model.appUser.profileImage != null
                          ? NetworkImage("${model.appUser.profileImage}")
                          : AssetImage('assets/profile_icon.png')
                              as ImageProvider,
                      radius: 50,
                    ),
                  ),
                  Text(
                    model.appUser.userName == null
                        ? 'Theresa Khan'
                        : model.appUser.userName.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 50,
                  ),

                  CustomExpansionTile(
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    title: Text(
                      "Watching",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    leadingSvgPath: "assets/watching.svg",
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 110, top: 15, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Currently watching",
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Watched"),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Watching"),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomExpansionTile(
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    title: Text(
                      "Reading",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    leadingSvgPath: "assets/book.svg",
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 110, top: 15, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Currently Reading"),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Read"),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Reading"),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  CustomExpansionTile(
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    title: Text(
                      "Listening",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    leadingSvgPath: "assets/music.svg",
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 110, top: 15, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Currently Listening"),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Listened"),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Listening"),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  CustomExpansionTile(
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    title: Text(
                      "Recommendations",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    leadingSvgPath: "assets/like.svg",
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 110, top: 15, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Currently Recommend"),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Recommended"),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Recommending"),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  CustomExpansionTile(
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    title: Text(
                      "Profile Setting",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leadingSvgPath: "assets/Setting.svg",
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       right: 180, top: 15, bottom: 15),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text("Currently watching"),
                      //       SizedBox(
                      //         height: 10,
                      //       ),
                      //       Text("Watched"),
                      //       SizedBox(
                      //         height: 10,
                      //       ),
                      //       Text("Watching"),
                      //       SizedBox(

                      //         height: 10,
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                      title: "Logout",
                      onTap: () async {
                        await model.locateUser.logoutUser();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SplashScreen()));
                      }),

                  // SizedBox(
                  //   height: 10,
                  // ),
                  // CustomExpansionTile(
                  //   title: "Reading",
                  //   svg: "assets/book.svg",
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // CustomExpansionTile(
                  //   title: "Listening",
                  //   svg: "assets/music.svg",
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // CustomExpansionTile(
                  //   title: "Recommendations",
                  //   svg: "assets/like.svg",
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // CustomExpansionTile(
                  //   title: "Setting",
                  //   svg: "assets/Setting.svg",
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),

                  // ExpandableListView(
                  //   title: "Watching",
                  //   svg: "assets/watching.svg",
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // ExpandableListView(
                  //   title: "Reading",
                  //   svg: "assets/book.svg",
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // ExpandableListView(
                  //   title: "Listening",
                  //   svg: "assets/music.svg",
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // ExpandableListView(
                  //   title: "Recomendation",
                  //   svg: "assets/like.svg",
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // ExpandableListView(
                  //   title: "Profile Setting",
                  //   svg: "assets/Setting.svg",
                  // ),
                ],
              ),
            ),
          );
        }));
  }
}
