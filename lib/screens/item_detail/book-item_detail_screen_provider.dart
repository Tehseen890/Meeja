import 'package:intl/intl.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meeja/core/locator.dart';
import 'package:meeja/core/models/base_view_model.dart';
import 'package:meeja/core/models/book_model.dart';
import 'package:meeja/core/models/firebase-movie_model.dart';
import 'package:meeja/core/models/firebase_book_model.dart';
import 'package:meeja/core/models/firebase_music_model.dart';

import 'package:meeja/core/models/movies_review_model.dart';

import '../../core/enums/view_state.dart';
import '../../core/models/activity_model.dart';
import '../../core/models/app_user.dart';
import '../../core/services/auth_services.dart';
import '../../core/services/database_services.dart';
import '../widget/custom_snackbar.dart';

class BookItemDetailScreenProvider extends BaseViewModal {
  bool isActiveButton = true;
  int index = 0;
  // bool enableButton = true;
  //List<AppUser> allAppUsers = [];
  // List<AppUser> Users = [];
  Stream<QuerySnapshot>? stream;
  Stream<QuerySnapshot>? reviewListStream;
  StreamSubscription<QuerySnapshot>? subscription;

  List<FirebaseBookModel> readList = [];
  List<FirebaseBookModel> reviewLists = [];
  List<FireBaseMovieModel> watchList = [];
  List<FireBaseMovieModel> reviewList = [];
  List<FirebaseMusicModel> listenList = [];
  List<FirebaseMusicModel> reviewsList = [];
  List<MoviesReview> moviesReviewsList = [];
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

  BookItemDetailScreenProvider(getData) {
    getReadList(getData);
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

/////////////////set book data///
  ///
  ///
  addToRead(Items items, BuildContext context) async {
    setState(ViewState.busy);
    var now = new DateTime.now();
    String formattedTime = DateFormat.yMd().format(now);
    final result = await _databaseServices.firebaseBookFetching(
        firebaseBookModel: FirebaseBookModel(
          bookTitle: items.volumeInfo!.title,
          bookSubtitle: items.volumeInfo!.subtitle,
          review: firebaseBookModel.review,
          sentAt: firebaseBookModel.sentAt = formattedTime,
          userId: locateUser.appUser.appUserId,
          userName: locateUser.appUser.fullName,
          userImage: locateUser.appUser.profileImage,
        ),
        resultId: items.id,
        userId: locateUser.appUser.appUserId);

    if (result != true) {
      customSnackBar(context, "Could not send Request");
      print("not added to list ");
    } else {
      customSnackBar(
        context,
        "Book added to List",
        // behavior: SnackBarBehavior.fixed,
      );
      //// userIds = [];

      for (int i = 0; i < readList.length; i++) {
        if (readList[i].userId != null) {
          userIds.add(readList[i].userId.toString());
          //   userIds.add(locateUser.appUser.appUserId.toString());
          //  userIds.add(locateUser.appUser.appUserId.toString());
        }
      }
      // userIds = [];

      userIds.add(locateUser.appUser.appUserId.toString());
      // userIds = [];

      await _databaseServices.setActivity(
        activityModel: ActivityModel(
          description: items.volumeInfo!.subtitle,
          title: items.volumeInfo!.title,
          image: items.volumeInfo!.imageLinks!.smallThumbnail,
          //   author: items.volumeInfo?.authors.toString(),
          itemId: items.id,
          userId: userIds,

          type: activityModel.type = 'Book',

          // print(userId);
        ),
        resultId: items.id,
      );

      print(userIds.length);

      customSnackBar(
        context,
        "Book added to List",
        // behavior: SnackBarBehavior.fixed,
      );
      // userIds = [];
      // await Future.delayed(Duration(seconds: 2));
      print('INSIDE ELSE BLOCK=======================================>');
    }
    setState(ViewState.idle);
  }

  addReview(Items results, BuildContext context) async {
    print('add review');
    print('add review');
    print('add review');
    print('add review');
    var now = new DateTime.now();
    String formattedTime = DateFormat.yMd().format(now);

    try {
      print('enter review');
      await _databaseServices.addfirebaseMoviereview(
          moviesReview: MoviesReview(
            userId: locateUser.appUser.appUserId,
            userName: locateUser.appUser.userName,
            userImage: locateUser.appUser.profileImage,
            sentAt: formattedTime,
            review: moviesReview.review,
          ),
          resultId: results.id);
    } catch (e) {
      print('errrrrooooooooooorrrrrrrr');
    }
  }

  /////////
  ///get book data
  ///
  getReadList(Items items) async {
    stream = await _databaseServices.getFirebaseBook(items.id);

    // subscription =
    stream!.listen((event) {
      print("Event length :: " + event.docs.length.toString());

      readList = [];

      event.docs.forEach(
        (element) {
          // for (int i = 0; i < userId.length; i++) {
          //   userId.add(element.id);
          // }
          print(element['userId']);

          readList.add(FirebaseBookModel.formJson(element, element.id));

          notifyListeners();
        },
      );
      //
      for (int i = 0; i < readList.length; i++) {
        if (readList[i].userId == locateUser.appUser.appUserId) {
          print('isssssss');
          isActiveButton = false;
          notifyListeners();
        }
      }
    });

    reviewListStream =
        await _databaseServices.getFirebaseMovieReviews(items.id);

    reviewListStream!.listen((event) {
      print("Event length :: " + event.docs.length.toString());

      moviesReviewsList = [];

      event.docs.forEach(
        (element) {
          print(element['userName']);

          moviesReviewsList.add(MoviesReview.formJson(element, element.id));

          notifyListeners();
        },
      );
    });
  }

  // @override
  // void dispose() {
  //   subscription!.cancel();
  //   // TODO: implement dispose
  //   super.dispose();
  // }
}
