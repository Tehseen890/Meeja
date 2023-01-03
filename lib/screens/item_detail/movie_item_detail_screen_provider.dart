import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meeja/core/locator.dart';
import 'package:meeja/core/models/base_view_model.dart';

import 'package:meeja/core/models/firebase-movie_model.dart';
import 'package:meeja/core/models/firebase_book_model.dart';
import 'package:meeja/core/models/firebase_music_model.dart';
import 'package:meeja/core/models/movie_model.dart';
import 'package:meeja/core/models/movies_review_model.dart';

import '../../core/enums/view_state.dart';
import '../../core/models/activity_model.dart';
import '../../core/models/app_user.dart';
import '../../core/services/auth_services.dart';
import '../../core/services/database_services.dart';
import '../widget/custom_snackbar.dart';

class MovieItemDetailScreenProvider extends BaseViewModal {
  bool isActiveButton = true;
  int index = 0;
  // bool enableButton = true;
  //List<AppUser> allAppUsers = [];
  // List<AppUser> Users = [];
  Stream<QuerySnapshot>? watchListStream;
  Stream<QuerySnapshot>? reviewListStream;
  List<FirebaseBookModel> readList = [];
  List<FireBaseMovieModel> watchList = [];
  List<MoviesReview> reviewList = [];
  List<FirebaseMusicModel> listenList = [];
  List<FirebaseMusicModel> reviewsList = [];

  //Results results = Results();
  DatabaseServices _databaseServices = DatabaseServices();
  List<AppUser> allAppUsers = [];
  FireBaseMovieModel fireBaseMovieModel = FireBaseMovieModel();
  MoviesReview moviesReview = MoviesReview();
  FirebaseBookModel firebaseBookModel = FirebaseBookModel();
  FirebaseMusicModel firebaseMusicModel = FirebaseMusicModel();
  ActivityModel activityModel = ActivityModel();
  List<AppUser> readUser = [];

  List<String> userIds = [];

  final locateUser = locator<AuthServices>();
  // bool get Readmore => isReadmore;
  // set Readmore(bool value) {
  //   isReadmore = value;
  //   notifyListeners();
  // }

  MovieItemDetailScreenProvider(getData) {
    getwatchList(getData);
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

/////////
  ///set movie data
  ///
  addToWatch(Results results, BuildContext context) async {
    final result;
    setState(ViewState.busy);
    var now = new DateTime.now();
    String formattedTime = DateFormat.yMd().format(now);

    result = await _databaseServices.firebaseMovieFetching(
        fireBaseMovieModel: FireBaseMovieModel(
          movieTitle: results.title,
          review: fireBaseMovieModel.review,
          sentAt: fireBaseMovieModel.sentAt = formattedTime,
          userId: locateUser.appUser.appUserId,
          userName: locateUser.appUser.fullName,
          userImage: locateUser.appUser.profileImage,
        ),
        resultId: results.id,
        userId: locateUser.appUser.appUserId);

    if (result != true) {
      // customSnackBar(context, "Could not send Request");
      print("not added to list ");
    } else {
      // userIds = [];
      for (int i = 0; i < watchList.length; i++) {
        print('object');
        if (watchList[i].userId != null) {
          print("wachList=============>");
          userIds.add(watchList[i].userId.toString());
          //   userIds.add(locateUser.appUser.appUserId.toString());
        }
      }
      userIds.add(locateUser.appUser.appUserId.toString());
      // userIds.forEach((element) {
      //   print(element);
      // });
      await _databaseServices.setActivity(
        activityModel: ActivityModel(
          description: results.description,
          title: results.title,
          image: results.image,
          itemId: results.id,
          userId: userIds,
          type: activityModel.type = "movie",
          // print(userId);
        ),
        resultId: results.id,
      );
      //userIds = [];
      // print(userIds.length);
//
      customSnackBar(
        context,
        "movie added to List",
        // behavior: SnackBarBehavior.fixed,
      );

      // await Future.delayed(Duration(seconds: 2));
      print('INSIDE ELSE BLOCK=======================================>');
    }

    //userIds = [];

    setState(ViewState.idle);
  }

  /////////
  ///add reviews
  ///

  addReview(Results results, BuildContext context) async {
    var now = new DateTime.now();
    String formattedTime = DateFormat.yMd().format(now);

    try {
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

/////////
  ///get watchlist
  ///
  ///

  getwatchList(Results results) async {
    watchListStream = await _databaseServices.getFirebaseMovie(results.id);

    watchListStream!.listen((event) {
      print("Event length :: " + event.docs.length.toString());

      watchList = [];

      event.docs.forEach(
        (element) {
          // for (int i = 0; i < userId.length; i++) {
          //   userId.add(element.id);
          // }
          print(element['userId']);

          watchList.add(FireBaseMovieModel.formJson(element, element.id));
          print(watchList[0].movieTitle);

          notifyListeners();
        },
      );

      //
      for (int i = 0; i < watchList.length; i++) {
        // if (watchList[i].review != null) {
        // }
        if (watchList[i].userId == locateUser.appUser.appUserId) {
          print('isssssss');
          isActiveButton = false;
          notifyListeners();
        }
      }
    });

    /////////
    ///   review List
    ///

    reviewListStream =
        await _databaseServices.getFirebaseMovieReviews(results.id);

    reviewListStream!.listen((event) {
      print("Event length :: " + event.docs.length.toString());

      reviewList = [];

      event.docs.forEach(
        (element) {
          print(element['userName']);

          reviewList.add(MoviesReview.formJson(element, element.id));

          notifyListeners();
        },
      );
    });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }
}
