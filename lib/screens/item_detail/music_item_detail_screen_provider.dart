import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meeja/core/locator.dart';
import 'package:meeja/core/models/base_view_model.dart';
import 'package:meeja/core/models/book_model.dart';
import 'package:meeja/core/models/firebase-movie_model.dart';
import 'package:meeja/core/models/firebase_book_model.dart';
import 'package:meeja/core/models/firebase_music_model.dart';
import 'package:meeja/core/models/movie_model.dart';
import 'package:meeja/core/models/movies_review_model.dart';
import 'package:meeja/core/models/music_model.dart';

import '../../core/enums/view_state.dart';
import '../../core/models/activity_model.dart';
import '../../core/models/app_user.dart';
import '../../core/services/auth_services.dart';
import '../../core/services/database_services.dart';
import '../widget/custom_snackbar.dart';

class MusicItemDetailScreenProvider extends BaseViewModal {
  bool isActiveButton = true;
  int index = 0;
  // bool enableButton = true;
  //List<AppUser> allAppUsers = [];
  // List<AppUser> Users = [];
  Stream<QuerySnapshot>? stream;
  Stream<QuerySnapshot>? reviewListStream;

  List<FirebaseBookModel> reviewLists = [];

  List<FireBaseMovieModel> reviewList = [];
  List<FirebaseMusicModel> listenList = [];
  List<MoviesReview> musicReviewsList = [];

  //Results results = Results();
  DatabaseServices _databaseServices = DatabaseServices();
  List<AppUser> allAppUsers = [];
  FireBaseMovieModel fireBaseMovieModel = FireBaseMovieModel();
  FirebaseBookModel firebaseBookModel = FirebaseBookModel();
  FirebaseMusicModel firebaseMusicModel = FirebaseMusicModel();
  ActivityModel activityModel = ActivityModel();
  MoviesReview moviesReview = MoviesReview();
  List<AppUser> readUser = [];

  List<String> userIds = [];

  final locateUser = locator<AuthServices>();
  // bool get Readmore => isReadmore;
  // set Readmore(bool value) {
  //   isReadmore = value;
  //   notifyListeners();
  // }

  MusicItemDetailScreenProvider(getData) {
    getListenList(getData);
    // getReview(getData);
    //getAppUsers();
  }
  // buttonPressed() {
  //   enableButton = false;
  //   notifyListeners();
  // }

  changeActiveColor(int x) {
    index = x;
    notifyListeners();
  }

/////
  ///set music data
  ///
  addToList(Data data, BuildContext context) async {
    setState(ViewState.busy);
    var now = new DateTime.now();
    String formattedTime = DateFormat.yMd().format(now);

    final result = await _databaseServices.firebaseMusicFetching(
        firebaseMusicModel: FirebaseMusicModel(
          musicSubtitle: data.title,
          musicTitle: data.titleShort,
          review: firebaseMusicModel.review,
          sentAt: firebaseMusicModel.sentAt = formattedTime,
          userId: locateUser.appUser.appUserId,
          userName: locateUser.appUser.fullName,
          userImage: locateUser.appUser.profileImage,
        ),
        resultId: data.id.toString(),
        userId: locateUser.appUser.appUserId);

    if (result != true) {
      customSnackBar(context, "Could not send Request");
      print("not added to list ");
    } else {
      for (int i = 0; i < listenList.length; i++) {
        if (listenList[i].userId != null) {
          userIds.add(listenList[i].userId.toString());
          // userIds.add(locateUser.appUser.appUserId.toString());
        }
      }
      userIds.add(locateUser.appUser.appUserId.toString());

      await _databaseServices.setActivity(
          activityModel: ActivityModel(
            description: data.title,
            title: data.titleShort,
            image: data.artist!.picture,
            userId: userIds,
            type: activityModel.type = 'Music',
            itemId: data.id.toString(),

            // print(userId);
          ),
          resultId: data.id.toString());

      print(userIds.length);

      customSnackBar(
        context,
        "Music added to List",
        // behavior: SnackBarBehavior.fixed,
      );

      // await Future.delayed(Duration(seconds: 2));
      print('INSIDE ELSE BLOCK=======================================>');
    }
    setState(ViewState.idle);
  }

  addReview(Data results, BuildContext context) async {
    print("addReview");
    var now = new DateTime.now();
    String formattedTime = DateFormat.yMd().format(now);

    try {
      print("Try Block");
      await _databaseServices.addfirebaseMoviereview(
          moviesReview: MoviesReview(
            userId: locateUser.appUser.appUserId,
            userName: locateUser.appUser.userName,
            userImage: locateUser.appUser.profileImage,
            sentAt: formattedTime,
            review: moviesReview.review,
          ),
          resultId: results.id);
    } catch (e) {}
  }
//
//get music data
//

  getListenList(Data data) async {
    print("get listennnnnnnn");
    stream = await _databaseServices.getFirebasemusic(data.id);
    print("getfirebasemusic");
    stream!.listen((event) {
      print("stream musiccccc");
      print("Event length :: " + event.docs.length.toString());

      listenList = [];

      event.docs.forEach(
        (element) {
          // for (int i = 0; i < userId.length; i++) {
          //   userId.add(element.id);
          // }
          print(element['userId']);

          listenList.add(FirebaseMusicModel.formJson(element, element.id));

          notifyListeners();
        },
      );
      //
      for (int i = 0; i < listenList.length; i++) {
        // if (listenList[i].review != null) {
        //   reviewsList.add(listenList[i]);
        // }
        if (listenList[i].userId == locateUser.appUser.appUserId) {
          print('isssssss');
          isActiveButton = false;
          notifyListeners();
        }
      }
    });
    reviewListStream = await _databaseServices.getFirebaseMovieReviews(data.id);

    reviewListStream!.listen((event) {
      print("Event length :: " + event.docs.length.toString());

      musicReviewsList = [];

      event.docs.forEach(
        (element) {
          print(element['userName']);

          musicReviewsList.add(MoviesReview.formJson(element, element.id));

          notifyListeners();
        },
      );
    });
  }
}
