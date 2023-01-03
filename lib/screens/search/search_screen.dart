import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:meeja/core/constants/colors.dart';
import 'package:meeja/screens/item_detail/movie_detail_screen%20.dart';
import 'package:meeja/screens/item_detail/book_detail_screen.dart';
import 'package:meeja/screens/item_detail/music_detail_screen.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'search_provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchProvider(),
      child: Consumer<SearchProvider>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xffFEF6F5),
            title: Center(
                child: Text(
              "Search",
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
                      top: 20, left: 10, right: 10, bottom: 10),
                  child: TextFormField(
                    onFieldSubmitted: (value) async {
                      // setState(() {
                      //   isSearch = true;
                      // });
                      await model.searchAll(value, context);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      contentPadding: EdgeInsets.all(10.0),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search Here",
                      suffixIcon: Container(
                        padding: const EdgeInsets.all(0),
                        decoration: new BoxDecoration(
                          color: orangeColor,
                          borderRadius: new BorderRadius.all(
                            Radius.circular(100.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownButton<String>(
                            underline: null,
                            icon: model.dropdownValue == 'All'
                                ? Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  )
                                : model.dropdownValue == 'Movie'
                                    ? Icon(
                                        Icons.movie_outlined,
                                        color: Colors.white,
                                      )
                                    : model.dropdownValue == 'Music'
                                        ? Icon(
                                            Icons.music_note_outlined,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.book_outlined,
                                            color: Colors.white,
                                          ),
                            value: model.dropdownValue,
                            items: <String>['All', 'Movie', 'Music', 'Book']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              model.getDropdown(newValue);
                            },
                          ),
                        ),

                        // child: IconButton(

                        //     icon: Icon(Icons.align_horizontal_left),
                        //     color: Colors.white,
                        //     onPressed: () {}),
                      ),
                      hintStyle:
                          TextStyle(color: Color.fromARGB(115, 46, 46, 46)),
                    ),
                  ),
                ),
                model.isSearch
                    ? SizedBox()
                    : Column(
                        children: [
                          model.dropdownValue == 'All' ||
                                  model.dropdownValue == 'Movie'
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Center(
                                          child: Text(
                                        "Movies",
                                        style: TextStyle(
                                            color: orangeColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      model.searchMovie == null
                                          ? getShimmer()
                                          : ListView.builder(
                                              itemCount:
                                                  model.searchMovie!.length,
                                              shrinkWrap: true,
                                              padding: EdgeInsets.only(top: 16),
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  // model.selectedMovie = index;
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            MovieDetailScreen(
                                                          getData: model
                                                                  .searchMovie![
                                                              index],
                                                          //  getGroup: getGroup,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Column(
                                                    // mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                height: 110.h,
                                                                width: 130.w,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  child:
                                                                      FadeInImage(
                                                                    // height: 110.h,
                                                                    // width: 130.w,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    placeholder:
                                                                        AssetImage(
                                                                            'assets/Loading_icon.gif'),
                                                                    image: NetworkImage(
                                                                        "${model.searchMovie![index].image}"),
                                                                  ),
                                                                )),
                                                            // Container(
                                                            //   height: 110,
                                                            //   width: 130,
                                                            //   decoration: BoxDecoration(
                                                            //     borderRadius:
                                                            //         BorderRadius.circular(
                                                            //             10),
                                                            //     image: DecorationImage(
                                                            //       image:

                                                            //        NetworkImage(
                                                            //           "${model.searchMovie![index].image}")
                                                            //           ,
                                                            //       fit: BoxFit.cover,
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      model
                                                                          .searchMovie![
                                                                              index]
                                                                          .title
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),

                                                                    Text(
                                                                      model
                                                                          .searchMovie![
                                                                              index]
                                                                          .description
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    // RichText(
                                                                    //   text: TextSpan(
                                                                    //       model.searchBook![index]
                                                                    //           .description,
                                                                    //       style: TextStyle(
                                                                    //           fontSize: 14,
                                                                    //           color: Colors.black),
                                                                    //       children: <TextSpan>[
                                                                    //         // TextSpan(
                                                                    //         //   text: "(Author)",
                                                                    //         //   style: TextStyle(
                                                                    //         //     color: Colors.grey,
                                                                    //         //   ),
                                                                    //         // ),
                                                                    //       ]),
                                                                    // ),
                                                                    // Padding(
                                                                    //   padding:
                                                                    //       const EdgeInsets.only(
                                                                    //           right: 80),
                                                                    //   child: Row(
                                                                    //     children: [
                                                                    //       IconButton(
                                                                    //         onPressed: () {},
                                                                    //         icon:
                                                                    //             Icon(Icons.star),
                                                                    //         color: Colors.grey,
                                                                    //       ),
                                                                    //       Text(
                                                                    //         "100%",
                                                                    //         style: TextStyle(
                                                                    //             color:
                                                                    //                 Colors.grey,
                                                                    //             fontSize: 15,
                                                                    //             fontWeight:
                                                                    //                 FontWeight
                                                                    //                     .bold),
                                                                    //       )
                                                                    //     ],
                                                                    //   ),
                                                                    // )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          model.dropdownValue == 'All' ||
                                  model.dropdownValue == 'Book'
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Center(
                                          child: Text(
                                        "Books",
                                        style: TextStyle(
                                            color: orangeColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      model.searchBook == null
                                          ? getShimmer()
                                          : ListView.builder(
                                              itemCount:
                                                  model.searchBook!.length,
                                              shrinkWrap: true,
                                              padding: EdgeInsets.only(top: 16),
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  // model.selectedMovie = index;
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            BookDetailScreen(
                                                          getData:
                                                              model.searchBook![
                                                                  index],
                                                          //  getGroup: getGroup,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Column(
                                                    // mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                height: 110.h,
                                                                width: 130.w,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  child:
                                                                      FadeInImage(
                                                                    // height: 110.h,
                                                                    // width: 130.w,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    placeholder:
                                                                        AssetImage(
                                                                            'assets/Loading_icon.gif'),
                                                                    image: NetworkImage(
                                                                        "${model.searchBook![index].volumeInfo!.imageLinks!.smallThumbnail}"),
                                                                  ),
                                                                )),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      model
                                                                          .searchBook![
                                                                              index]
                                                                          .volumeInfo!
                                                                          .title
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),

                                                                    Text(
                                                                      model
                                                                          .searchBook![
                                                                              index]
                                                                          .volumeInfo!
                                                                          .subtitle
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    RichText(
                                                                      text: TextSpan(
                                                                          text:
                                                                              "${model.searchBook![index].volumeInfo!.authors.toString()}",
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: Colors.black),
                                                                          children: <TextSpan>[
                                                                            // TextSpan(
                                                                            //   text: "(Author)",
                                                                            //   style: TextStyle(
                                                                            //     color: Colors.grey,
                                                                            //   ),
                                                                            // ),
                                                                          ]),
                                                                    ),
                                                                    // Padding(
                                                                    //   padding:
                                                                    //       const EdgeInsets.only(
                                                                    //           right: 80),
                                                                    //   child: Row(
                                                                    //     children: [
                                                                    //       IconButton(
                                                                    //         onPressed: () {},
                                                                    //         icon:
                                                                    //             Icon(Icons.star),
                                                                    //         color: Colors.grey,
                                                                    //       ),
                                                                    //       Text(
                                                                    //         "100%",
                                                                    //         style: TextStyle(
                                                                    //             color:
                                                                    //                 Colors.grey,
                                                                    //             fontSize: 15,
                                                                    //             fontWeight:
                                                                    //                 FontWeight
                                                                    //                     .bold),
                                                                    //       )
                                                                    //     ],
                                                                    //   ),
                                                                    // )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          model.dropdownValue == 'All' ||
                                  model.dropdownValue == 'Music'
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Center(
                                          child: Text(
                                        "Music",
                                        style: TextStyle(
                                            color: orangeColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      model.searchMusic == null
                                          ? getShimmer()
                                          : ListView.builder(
                                              itemCount:
                                                  model.searchMusic!.length,
                                              shrinkWrap: true,
                                              padding: EdgeInsets.only(top: 16),
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  // model.selectedMovie = index;
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            MusicDetailScreen(
                                                          getData: model
                                                                  .searchMusic![
                                                              index],
                                                          //  getGroup: getGroup,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Column(
                                                    // mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                height: 110.h,
                                                                width: 130.w,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  child:
                                                                      FadeInImage(
                                                                    // height: 110.h,
                                                                    // width: 130.w,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    placeholder:
                                                                        AssetImage(
                                                                            'assets/Loading_icon.gif'),
                                                                    image: NetworkImage(
                                                                        "${model.searchMusic![index].artist!.picture}"),
                                                                  ),
                                                                )),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      model
                                                                          .searchMusic![
                                                                              index]
                                                                          .titleShort
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),

                                                                    Text(
                                                                      model
                                                                          .searchMusic![
                                                                              index]
                                                                          .title
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    // RichText(
                                                                    //   text: TextSpan(
                                                                    //       model.searchBook![index]
                                                                    //           .description,
                                                                    //       style: TextStyle(
                                                                    //           fontSize: 14,
                                                                    //           color: Colors.black),
                                                                    //       children: <TextSpan>[
                                                                    //         // TextSpan(
                                                                    //         //   text: "(Author)",
                                                                    //         //   style: TextStyle(
                                                                    //         //     color: Colors.grey,
                                                                    //         //   ),
                                                                    //         // ),
                                                                    //       ]),
                                                                    // ),
                                                                    // Padding(
                                                                    //   padding:
                                                                    //       const EdgeInsets.only(
                                                                    //           right: 80),
                                                                    //   child: Row(
                                                                    //     children: [
                                                                    //       IconButton(
                                                                    //         onPressed: () {},
                                                                    //         icon:
                                                                    //             Icon(Icons.star),
                                                                    //         color: Colors.grey,
                                                                    //       ),
                                                                    //       Text(
                                                                    //         "100%",
                                                                    //         style: TextStyle(
                                                                    //             color:
                                                                    //                 Colors.grey,
                                                                    //             fontSize: 15,
                                                                    //             fontWeight:
                                                                    //                 FontWeight
                                                                    //                     .bold),
                                                                    //       )
                                                                    //     ],
                                                                    //   ),
                                                                    // )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                        ],
                      )
              ],
            ),
          ),
        );
      }),
    );
  }
}

Shimmer getShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey,
    child: Row(
      children: [
        shimmerContainer(
          height: 120,
          width: 120,
        ),
        Expanded(
          child: Column(
            children: [
              shimmerContainer(width: 80),
              SizedBox(
                height: 10,
              ),
              shimmerContainer(width: 200)
            ],
          ),
        )
      ],
    ),
  );
}

class shimmerContainer extends StatelessWidget {
  double? height, width;
  shimmerContainer({
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
