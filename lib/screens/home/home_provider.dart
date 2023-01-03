import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:meeja/core/enums/view_state.dart';
import 'package:meeja/core/models/add_friend_model.dart';
import 'package:meeja/core/models/base_view_model.dart';
import 'package:meeja/core/models/book_model.dart';
import 'package:meeja/core/models/movie_model.dart';
import 'package:meeja/core/models/music_model.dart';

import '../../core/locator.dart';
import '../../core/models/activity_model.dart';

import '../../core/services/auth_services.dart';
import '../../core/services/database_services.dart';

class HomeScreenProvider extends BaseViewModal {
  int index = 0;
  Results results = Results();
  Items items = Items();
  Data data = Data();
  List<ActivityModel> activityList = [];
  List<ActivityModel> filterActivityList = [];
  List<ActivityModel> filterBookList = [];
  List<ActivityModel> filterMusicList = [];
  List<ActivityModel> filterMovieList = [];
  List<ActivityModel> bookList = [];
  List<ActivityModel> musicList = [];
  List<ActivityModel> movieList = [];

  List tempList = [];
  final locateUser = locator<AuthServices>();
  Stream<QuerySnapshot>? stream;
  DatabaseServices _databaseServices = DatabaseServices();
  List<AddFriendModel> listOfFriends = [];
  List<AddFriendModel> watchedFriend = [];
  List<AddFriendModel> watchedFriendMovie = [];
  List<AddFriendModel> watchedFriendBook = [];
  List<AddFriendModel> watchedFriendMusic = [];
  changeIndexValue(int x) {
    index = x;
    notifyListeners();
  }

  HomeScreenProvider() {
    getActivity();
    print("this is friend name<<<<<<<<<<<<<<");
    // print(watchedFriend[0].friendName);
  }

  watchedUser(
    List<ActivityModel> activitymodel,
    List<AddFriendModel> watchedUser,
    List<ActivityModel> activityties,
  ) {
    activitymodel.forEach((activity) {
      print("activity List");
      // print(element.userId?[0]);

      ActivityModel activityModel = ActivityModel();
      // element.userId?.firstWhere((element) {

      // });
      activity.userId?.forEach((userIds) {
        print("eACH USER ID");
        // print(listOfFriends[0].friendName);
        // print(userIds);
        listOfFriends.forEach((element) {
          if (element.friendId == userIds) {
            print('forterlllllll');

            activityModel = activity;
          }
        });

        print("added");
      });
      print("end of loop");

      if (activityModel.itemId != null) {
        print("List of activity added<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
        activityties.add(activityModel);
        //  print("this is ${filterActivityList.length}");
      }
      //  activityModel.itemId == null ? null : activityties.add(activityModel);
    });

    filterActivityList.forEach((filterActivity) {
      AddFriendModel addFriendModel = AddFriendModel();
      filterActivity.userId?.forEach((userIds) {
        listOfFriends.forEach((friend) {
          if (friend.friendId == userIds) {
            addFriendModel = friend;
          }
        });
      });
      watchedUser.add(addFriendModel);
    });

    //  print(watchedUser.length);
  }

  // getSpecificData() {
  //   print("get specific data called");
  //   for (int i = 0; i < activityList.length; i++) {
  //     print(activityList[i].type);
  //     if (activityList[i].type == 'Book') {
  //       bookList.add(activityList[i]);
  //     }
  //   }
  //   notifyListeners();
  // }
  // getAppUsers() async {
  //   setState(ViewState.busy);
  //   aStreamSubscriptionllAppUsers = await _databaseServices.getAllAppUser();

  //   setState(ViewState.idle);
  // }
  ///
  getActivity() async {
    setState(ViewState.busy);
    listOfFriends = await _databaseServices.getFriends();
    stream = _databaseServices.getActivity();

    stream!.listen((event) {
      if (event.docs.length > 0) {
        //  print("Event length :: " + event.docs.length.toString());

        activityList = [];
        bookList = [];
        musicList = [];
        movieList = [];

        event.docs.forEach((element) {
          activityList.add(ActivityModel.formJson(element, element.id));

          notifyListeners();
          //    print("leprot ${element['type']}");

          if (element['type'] == 'Book') {
            bookList.add(ActivityModel.formJson(element, element.id));
            print(bookList);
            //   watchedUser(bookList, watchedFriendBook);
          } else if (element['type'] == 'Music') {
            musicList.add(ActivityModel.formJson(element, element.id));
            print(musicList);
            //   watchedUser(musicList, watchedFriendMusic);
          }
          // notifyListeners();
          else if (element['type'] == 'movie') {
            movieList.add(ActivityModel.formJson(element, element.id));
            print(movieList);
            //  watchedUser(movieList, watchedFriendMovie);
          } else {
            print("empty list");
          }
          setState(ViewState.idle);
          //notifyListeners();
        });
        watchedUser(activityList, watchedFriend, filterActivityList);
        watchedUser(bookList, watchedFriendBook, filterBookList);
        watchedUser(musicList, watchedFriendMusic, filterMusicList);
        watchedUser(movieList, watchedFriendMovie, filterMovieList);

        //   for (int i = 0; i < activityList.length; i++) {
        //     print(activityList[i].type);
        //     if (activityList[i].type == 'Book') {
        //       bookList.add(activityList[i]);
        //     }
        //     if (activityList[i].type == 'Music') {
        //       musicList.add(activityList[i]);
        //     }
        //     if (activityList[i].type == 'movie') {
        //       movieList.add(activityList[i]);
        //     }
        //   }
        // }

      }
    });
  }

  getData(ActivityModel activityModel) {
    if (activityModel.type == 'movie') {
      results = Results(
        id: activityModel.itemId,
        resultType: activityModel.type,
        image: activityModel.image,
        title: activityModel.title,
        description: activityModel.description,
        user: activityModel.userId,
      );
    } else if (activityModel.type == 'Book') {
      items = Items(
        id: activityModel.itemId,
        volumeInfo: VolumeInfo(
          title: activityModel.title,
          imageLinks: ImageLinks(smallThumbnail: activityModel.image),
          description: activityModel.description,
        ),
      );
    } else if (activityModel.type == 'Music') {
      data = Data(
        id: int.parse(activityModel.itemId.toString()),
        type: activityModel.type,
        artist: Artist(picture: activityModel.image),
        titleShort: activityModel.title,
      );
    }
  }
}
