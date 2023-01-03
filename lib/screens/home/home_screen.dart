import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeja/core/enums/view_state.dart';

import 'package:meeja/screens/home/home_provider.dart';
import 'package:meeja/screens/item_detail/book_detail_screen.dart';
import 'package:meeja/screens/item_detail/movie_detail_screen%20.dart';
import 'package:meeja/screens/item_detail/music_detail_screen.dart';

import 'package:meeja/screens/widget/custom_appBar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../widget/elavatedButton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeScreenProvider>(
        create: (context) => HomeScreenProvider(),
        child: Consumer<HomeScreenProvider>(
          builder: (context, model, child) {
            return Scaffold(
              appBar: CustomAppBar(),
              // AppBar(
              //   leading: GestureDetector(
              //     onTap: () {
              //       Navigator.pop(context);
              //     },
              //     child: CircleAvatar(
              //       backgroundColor: Colors.white,
              //       radius: 5,
              //       child: Icon(
              //         Icons.arrow_back,
              //         color: Colors.black,
              //         size: 20,
              //       ),
              //     ),
              //   ),
              //   backgroundColor: Color(0xffFEF6F5),
              //   title: Center(
              //     child: SvgPicture.asset(
              //       "assets/Group.svg",
              //       color: orangeColor,
              //     ),
              //   ),
              //   actions: [
              //     IconButton(
              //       onPressed: () {},
              //       icon: Icon(
              //         Icons.notifications_active_outlined,
              //         color: Colors.black,
              //       ),
              //     ),
              //   ],
              // ),

              body: ModalProgressHUD(
                progressIndicator: CircularProgressIndicator(
                  color: orangeColor,
                ),
                inAsyncCall: model.state == ViewState.busy,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: ListView(
                            padding: EdgeInsets.only(bottom: 5),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            reverse: true,
                            children: [
                              CustomElevatedbutton(
                                title: 'All',
                                style: TextStyle(
                                    color: model.index == 0
                                        ? Colors.white
                                        : Colors.black),
                                getColor: model.index == 0
                                    ? orangeColor
                                    : Color(0xffFEF6F5),
                                onPressed: () {
                                  model.changeIndexValue(0);
                                },
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              CustomElevatedbutton(
                                title: "Music",
                                style: TextStyle(
                                    color: model.index == 1
                                        ? Colors.white
                                        : Colors.black),
                                getColor: model.index == 1
                                    ? orangeColor
                                    : Color(0xffFEF6F5),
                                onPressed: () {
                                  model.changeIndexValue(1);
                                },
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              CustomElevatedbutton(
                                title: 'Movies',
                                style: TextStyle(
                                    color: model.index == 2
                                        ? Colors.white
                                        : Colors.black),
                                getColor: model.index == 2
                                    ? orangeColor
                                    : Color(0xffFEF6F5),
                                onPressed: () {
                                  model.changeIndexValue(2);
                                },
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              CustomElevatedbutton(
                                title: 'Books',
                                style: TextStyle(
                                    color: model.index == 3
                                        ? Colors.white
                                        : Colors.black),
                                getColor: model.index == 3
                                    ? orangeColor
                                    : Color(0xffFEF6F5),
                                onPressed: () {
                                  model.changeIndexValue(3);
                                },
                              ),
                              SizedBox(
                                width: 8.w,
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 4,
                                shape: StadiumBorder(),
                                primary: Color(0xffFEF6F5),
                                // This is what you need!
                                padding: EdgeInsets.only(left: 10, right: 10),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Latest",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: orangeColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        model.index == 0
                            ? model.filterActivityList.isEmpty
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                      ),
                                      Text("No Data Yet"),
                                    ],
                                  )
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: model.filterActivityList.length,
                                    reverse: true,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                          onTap: () {
                                            model.getData(model
                                                .filterActivityList[index]);

                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => model
                                                            .filterActivityList[
                                                                index]
                                                            .type ==
                                                        'movie'
                                                    ? MovieDetailScreen(
                                                        getData: model.results,
                                                      )
                                                    : model
                                                                .filterActivityList[
                                                                    index]
                                                                .type ==
                                                            'Book'
                                                        ? BookDetailScreen(
                                                            getData:
                                                                model.items)
                                                        : MusicDetailScreen(
                                                            getData:
                                                                model.data),
                                              ),
                                            );
                                          },
                                          child: BoxContainer(model, index));
                                    },
                                  )
                            : SizedBox(),
                        model.index == 1
                            ? model.filterMusicList.isEmpty
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                      ),
                                      Text("No Data Yet"),
                                    ],
                                  )
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: model.filterMusicList.length,
                                    reverse: true,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                          onTap: () {
                                            model.getData(
                                                model.filterMusicList[index]);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MusicDetailScreen(
                                                            getData:
                                                                model.data)));
                                          },
                                          child:
                                              MusicBoxContainer(model, index));
                                    },
                                  )
                            : SizedBox(),
                        model.index == 2
                            ? model.filterMovieList.isEmpty
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                      ),
                                      Text("No Data Yet"),
                                    ],
                                  )
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: model.filterMovieList.length,
                                    reverse: true,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                          onTap: () {
                                            model.getData(
                                                model.filterMovieList[index]);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MovieDetailScreen(
                                                            getData: model
                                                                .results)));
                                          },
                                          child:
                                              MovieBoxContainer(model, index));
                                    },
                                  )
                            : SizedBox(),
                        model.index == 3
                            ? model.filterBookList.isEmpty
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                      ),
                                      Text("No Data Yet"),
                                    ],
                                  )
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: model.filterBookList.length,
                                    reverse: true,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                          onTap: () {
                                            model.getData(
                                                model.filterBookList[index]);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BookDetailScreen(
                                                            getData:
                                                                model.items)));
                                          },
                                          child:
                                              BookBoxContainer(model, index));
                                    },
                                  )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}

////////////////all data////////

Card BoxContainer(HomeScreenProvider model, int index) {
  return Card(
    margin: EdgeInsets.only(top: 10, bottom: 8, right: 7, left: 7),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    // decoration: BoxDecoration(),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          model.watchedFriend[index].friendName != null
              ? Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/profile3.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 10),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                '${model.watchedFriend[index].friendName} Is ',
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text: 'Watching',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10))
                        ],
                      ),
                    )
                  ],
                )
              : SizedBox(),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 140.h,
                  width: 130.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage(
                      // height: 110.h,
                      // width: 130.w,
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/Loading_icon.gif'),
                      image: NetworkImage(
                          "${model.filterActivityList[index].image}"),
                    ),
                  )),

              // SizedBox(
              //   width: 10,
              // ),
              Expanded(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              //Colors.orange;
                            },
                            icon: Icon(
                              Icons.star,
                              color: orangeColor,
                              //primary: _flag ? Colors.orange : Colors.grey,
                              size: 20,
                            )),
                        Text(
                          "100%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 0,
                        bottom: 10,
                      ),
                      child: Text(
                        model.filterActivityList[index].userId!.length
                                .toString() +
                            " Users Watched",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: model.filterActivityList[index].description == null
                          ? Text('')
                          : Text(
                              model.filterActivityList[index].description
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff968E8C)),
                            ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

///////
/// music data
///
Card MusicBoxContainer(HomeScreenProvider model, int index) {
  return Card(
    margin: EdgeInsets.only(top: 10, bottom: 8, right: 7, left: 7),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    // decoration: BoxDecoration(),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          model.watchedFriendMusic[index].friendName != null
              ? Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/profile3.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 10),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                '${model.watchedFriendMusic[index].friendName} is',
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text: 'Watching',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10))
                        ],
                      ),
                    )
                  ],
                )
              : SizedBox(),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 140.h,
                  width: 130.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage(
                      // height: 110.h,
                      // width: 130.w,
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/Loading_icon.gif'),
                      image:
                          NetworkImage("${model.filterMusicList[index].image}"),
                    ),
                  )),
              // SizedBox(
              //   width: 10,
              // ),
              Expanded(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              //Colors.orange;
                            },
                            icon: Icon(
                              Icons.star,
                              color: orangeColor,
                              //primary: _flag ? Colors.orange : Colors.grey,
                              size: 20,
                            )),
                        Text(
                          "100%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 0,
                        bottom: 10,
                      ),
                      child: Text(
                        model.filterMusicList[index].userId!.length.toString() +
                            " Users Watched",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: model.filterMusicList[index].description == null
                          ? Text('')
                          : Text(
                              model.filterMusicList[index].description
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff968E8C)),
                            ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

//////
///movie data
///
Card MovieBoxContainer(HomeScreenProvider model, int index) {
  return Card(
    margin: EdgeInsets.only(top: 10, bottom: 8, right: 7, left: 7),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    // decoration: BoxDecoration(),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          model.watchedFriendMovie[index].friendName != null
              ? Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/profile3.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 10),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                '${model.watchedFriendMovie[index].friendName} Is ',
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text: 'Watching',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10))
                        ],
                      ),
                    )
                  ],
                )
              : SizedBox(),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 140.h,
                  width: 130.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage(
                      // height: 110.h,
                      // width: 130.w,
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/Loading_icon.gif'),
                      image:
                          NetworkImage("${model.filterMovieList[index].image}"),
                    ),
                  )),
              // SizedBox(
              //   width: 10,
              // ),
              Expanded(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              //Colors.orange;
                            },
                            icon: Icon(
                              Icons.star,
                              color: orangeColor,
                              //primary: _flag ? Colors.orange : Colors.grey,
                              size: 20,
                            )),
                        Text(
                          "100%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 0,
                        bottom: 10,
                      ),
                      child: Text(
                        model.filterMovieList[index].userId!.length.toString() +
                            " Users Watched",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: model.filterMovieList[index].description == null
                          ? Text('')
                          : Text(
                              model.filterMovieList[index].description
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff968E8C)),
                            ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

////
///book movie
///
Card BookBoxContainer(HomeScreenProvider model, int index) {
  return Card(
    margin: EdgeInsets.only(top: 10, bottom: 8, right: 7, left: 7),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    // decoration: BoxDecoration(),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          model.watchedFriendBook[index].friendName != null
              ? Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/profile3.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 10),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                '${model.watchedFriendBook[index].friendName} Is ',
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text: 'Watching',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10))
                        ],
                      ),
                    )
                  ],
                )
              : SizedBox(),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 140.h,
                  width: 130.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage(
                      // height: 110.h,
                      // width: 130.w,
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/Loading_icon.gif'),
                      image:
                          NetworkImage("${model.filterBookList[index].image}"),
                    ),
                  )),
              // SizedBox(
              //   width: 10,
              // ),
              Expanded(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              //Colors.orange;
                            },
                            icon: Icon(
                              Icons.star,
                              color: orangeColor,
                              //primary: _flag ? Colors.orange : Colors.grey,
                              size: 20,
                            )),
                        Text(
                          "100%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 0,
                        bottom: 10,
                      ),
                      child: Text(
                        model.filterBookList[index].userId!.length.toString() +
                            " Users Watched",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: model.filterBookList[index].description == null
                          ? Text('')
                          : Text(
                              model.filterBookList[index].description
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff968E8C)),
                            ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
