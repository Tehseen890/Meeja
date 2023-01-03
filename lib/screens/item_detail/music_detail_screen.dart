import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:meeja/screens/item_detail/music_item_detail_screen_provider.dart';
import 'package:meeja/screens/recommend_item/recommend_item_screen.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';

import '../widget/custom_card.dart';
import '../widget/elavatedButton.dart';

import '../widget/customslider.dart';
import '../widget/sub_button.dart';
import '../widget/text_widget.dart';

class MusicDetailScreen extends StatelessWidget {
  bool isActiveButton = true;
  final getData;
  final maxLines;

  MusicDetailScreen({
    required this.getData,
    this.maxLines,
  });
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MusicItemDetailScreenProvider>(
      create: (context) => MusicItemDetailScreenProvider(getData),
      child: Consumer<MusicItemDetailScreenProvider>(
          builder: (context, model, child) {
        return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                backgroundColor: Color(0xffFEF6F5),
                title: Center(
                  child: SvgPicture.asset(
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
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          "${getData.titleShort}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // RichText(
                          //   text: TextSpan(
                          //     text: 'Murgan Housel ',
                          //     style: TextStyle(
                          //         fontSize: 13, color: Colors.black),
                          //     children: const <TextSpan>[
                          //       TextSpan(
                          //         text: '(Author)',
                          //         style: TextStyle(color: Colors.grey),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Text('Save'),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          height: 280,
                          width: 500,
                          decoration: new BoxDecoration(
                            //   color: Colors.orange,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage("${getData.artist!.picture}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),

                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${getData.titleShort}",
                                //  "mmmmmmmmmmmmmmmmmm",
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    height: 1.5),
                                maxLines: maxLines,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            maxLines == 3
                                ? Text(
                                    "Learn more...",
                                    style: TextStyle(color: Colors.orange),
                                  )
                                : Text(
                                    "",
                                    style: TextStyle(color: Colors.orange),
                                  ),
                          ],
                        ),
                        // child: RichText(
                        //   text: TextSpan(
                        //     text: "${getData!.description}",
                        //     style: TextStyle(
                        //         fontSize: 14, color: Colors.grey, height: 1.5),
                        //     children: const <TextSpan>[
                        //       TextSpan(
                        //         text: 'Learn more...',
                        //         style: TextStyle(color: Colors.orange),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: CustomElevatedbutton(
                                  onPressed: model.isActiveButton
                                      ? () {
                                          model.addToList(getData, context);
                                          model.isActiveButton = false;
                                        }
                                      : null,
                                  title: "Add to Listen",
                                  style: TextStyle(color: Colors.white),
                                  getColor: orangeColor),
                            ),
                            //: Colors.grey),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: CustomElevatedbutton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          RecommendedItem(getData)));
                                },
                                title: "Recommend Item",
                                style: TextStyle(color: Colors.white),
                                getColor: orangeColor,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 60,
                                width: 85,
                                child: Card(
                                  elevation: 5,
                                  margin: EdgeInsets.all(10.0),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white70, width: 1),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Icon(
                                    Icons.chat_outlined,
                                    color: orangeColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      model.listenList.isEmpty
                          ? SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 10),
                                  child: Text(
                                    "Who have Listen?",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: model.listenList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        height: 90,
                                        width: 70,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CircleAvatar(
                                              radius: 25,
                                              backgroundImage: model
                                                          .listenList[index]
                                                          .userImage !=
                                                      null
                                                  ? NetworkImage(
                                                      "${model.listenList[index].userImage}")
                                                  : AssetImage(
                                                          'assets/profile_icon.png')
                                                      as ImageProvider,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                model.listenList[index].userName
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 10, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Reviews",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.star,
                                color: orangeColor,
                                size: 15,
                              ),
                            ),
                            Text(
                              "(100%)",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextWidget(
                                    title: "Add Review",
                                    OnTap: () {
                                      openAlertBox(model, context, getData);
                                    }
                                    //openAlertBox(context),
                                    ),
                              ],
                            ),
                            TextWidget(
                              title: "See all",
                            ),
                          ],
                        ),
                      ),
                      model.musicReviewsList.isEmpty
                          ? SizedBox()
                          : GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2,
                              ),

                              // scrollDirection: Axis.horizontal,
                              itemCount: model.musicReviewsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CustomCard(
                                  name:
                                      model.musicReviewsList[index].userName ??
                                          "",
                                  review:
                                      model.musicReviewsList[index].review ??
                                          "",
                                  time: model.musicReviewsList[index].sentAt ??
                                      "",
                                  image: model.listenList[index].userImage !=
                                          null
                                      ? NetworkImage(
                                          "${model.listenList[index].userImage}")
                                      : AssetImage('assets/profile_icon.png')
                                          as ImageProvider,
                                );
                              }),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ));
      }),
    );
  }
}

openAlertBox(
  MusicItemDetailScreenProvider model,
  BuildContext context,
  getData,
) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            insetPadding:
                EdgeInsets.only(top: 150, bottom: 150, left: 10, right: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 20.0, left: 10, right: 10),
            content: Container(
              width: 700,
              child: Column(
                children: [
                  Text(
                    "Share Your Review",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customButton(),
                        SizedBox(
                          width: 20,
                        ),
                        customButton()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomSlider(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Column(children: [
                      TextFormField(
                        onChanged: (value) {
                          model.moviesReview.review = value;
                        },

                        // controller: textarea,
                        keyboardType: TextInputType.multiline,
                        maxLines: 8,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Write Something",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SubButton(
                            onpress: () {
                              print("Submit pressed");

                              model.addReview(getData, context);
                              Navigator.pop(context);
                            },
                            BText: "Submit",
                            style: TextStyle(color: Colors.white),
                            color: orangeColor,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: SubButton(
                            onpress: () {
                              Navigator.pop(context);
                            },
                            BText: "Cancel",
                            style: TextStyle(color: Colors.white),
                            color: orangeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

Container customButton() {
  return Container(
    height: 40,
    width: 130,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.grey),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Followers'),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_drop_down),
        ),
      ],
    ),
  );
}
