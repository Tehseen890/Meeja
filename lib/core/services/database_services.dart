import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:meeja/core/models/add_friend_model.dart';
import 'package:meeja/core/models/firebase_book_model.dart';
import 'package:meeja/core/models/firebase_music_model.dart';
import 'package:meeja/core/models/friend_message_model.dart';
import 'package:meeja/core/models/groups_model.dart';

import 'package:meeja/core/models/firebase-movie_model.dart';
import 'package:meeja/core/models/movies_review_model.dart';
import 'package:meeja/core/services/api_services.dart';
import '../locator.dart';
import '../models/activity_model.dart';
import '../models/app_user.dart';
import '../models/group_conversation_model.dart';
import 'auth_services.dart';

class DatabaseServices {
  final firebaseFireStore = FirebaseFirestore.instance;

  final apiServices = ApiServices();

  // getBooks() {
  //   apiServices.get(url: "https://www.googleapis.com/auth/books/");
  // }

  ///
  /// Add user
  ///
  registerUser(AppUser appUser) {
    try {
      firebaseFireStore
          .collection("AppUser")
          .doc(appUser.appUserId)
          .set(appUser.toJson());
    } catch (e) {
      print('Exception $e');
    }
  }

  ///
  /// Get user
  ///
  Future<AppUser> getUser(id) async {
    print('GetUser id: $id');
    try {
      final snapshot =
          await firebaseFireStore.collection('AppUser').doc(id).get();
      // print('Current app User Data: ${snapshot.data()}');
      return AppUser.fromJson(snapshot.data(), snapshot.id);
    } catch (e) {
      print('Exception @DatabaseService/getUser $e');
      return AppUser();
    }
  }

  ///
  /// get all app users
  ///
  Future<List<AppUser>> getAppUsers() async {
    final List<AppUser> appUserList = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('AppUser')
          .where('appUserId',
              isNotEqualTo: locator<AuthServices>().appUser.appUserId)
          .get();
      if (snapshot.docs.length > 0) {
        snapshot.docs.forEach((element) {
          appUserList.add(AppUser.fromJson(element, element.id));
          print("getUser => ${element['userName']}");
        });
      } else {
        print("No data found");
      }
    } catch (e) {
      print('Exception @DatabaseService/GetAllUsers $e');
    }
    return appUserList;
  }

  ///
  /// get all app users
  ///
  Future<List<AppUser>> getTopThreeUsers() async {
    final List<AppUser> appUserList = [];
    try {
      QuerySnapshot snapshot =
          await firebaseFireStore.collection('AppUser').get();
      if (snapshot.docs.length > 0) {
        snapshot.docs.forEach((element) {
          appUserList.add(AppUser.fromJson(element, element.id));
          print("getUser => ${element['userName']}");
        });
      } else {
        print("No data found");
      }
    } catch (e) {
      print('Exception @DatabaseService/GetAllUsers $e');
    }
    return appUserList;
  }

  updateUserProfile(AppUser appUser) async {
    try {
      await firebaseFireStore
          .collection('AppUser')
          .doc(appUser.appUserId)
          .update(appUser.toJson());
    } catch (e) {
      print('Exception@UpdateUserProfile=>$e');
    }
  }

  updateotherUserProfile(double zaps, String userId) async {
    try {
      await firebaseFireStore
          .collection('AppUser')
          .doc(userId.toString())
          .update({
        'faceCardNumber': zaps,
      });
    } catch (e) {
      print('Exception@UpdateUserProfile=>$e');
    }
  }
  ///////////////////// get all app user/////////////

  Future<List<AppUser>> getAllAppUser() async {
    final List<AppUser> appUserList = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('AppUser')
          .where('appUserId',
              isNotEqualTo: locator<AuthServices>().appUser.appUserId)
          .get();
      if (snapshot.docs.length > 0) {
        snapshot.docs.forEach((element) {
          appUserList.add(AppUser.fromJson(element, element.id));
          print("getUser => ${element['userName']}");
        });
      } else {
        print("No data found");
      }
    } catch (e) {
      print('Exception @DatabaseService/GetAllUsers $e');
    }
    return appUserList;
  }

  ////////////////////////group conversationlist//////////////

  // Future<Stream<QuerySnapshot<Object?>>?> getGroupConversationList(
  //     AppUser appUser) async {
  //   try {
  //     Stream<QuerySnapshot> snapshot = await firebaseFireStore
  //         .collection("Conversations")
  //         .doc(appUser.appUserId)
  //         .collection("Chats")
  //         .orderBy('lastMessageAt', descending: false)
  //         .snapshots();
  //     return snapshot;
  //   } catch (e) {
  //     print('Exception@GetUserConversationList$e');
  //     return null;
  //   }
  // }

  // addGroupMessage(
  //   AppUser currentAppUser,
  //   String groupId,
  //   GroupConversationModel conversation,
  // ) async {
  //   try {
  //     /// From group message
  //     ///
  //     await firebaseFireStore
  //         .collection("Conversations")
  //         .doc("${currentAppUser.appUserId}")
  //         .collection("Chats")
  //         .doc("$groupId")
  //         .collection("messages")
  //         .add(conversation.toJson());

  //     ///
  //     /// to group message
  //     ///
  //     await firebaseFireStore
  //         .collection("Conversations")
  //         .doc("$groupId")
  //         .collection("Chats")
  //         .doc("${currentAppUser.appUserId}")
  //         .collection("messages")
  //         .add(conversation.toJson());
  //     await firebaseFireStore
  //         .collection("Conversations")
  //         .doc("$groupId")
  //         .collection("Chats")
  //         .doc("${currentAppUser.appUserId}")
  //         .set(currentAppUser.toJson());
  //   } catch (e) {
  //     print('Exception@sentUserMessage$e');
  //   }
  // }

/////////////////create Group/////////////////

  createGroup(
    GroupModel groupModel,
  ) {
    try {
      firebaseFireStore.collection("Group").doc().set(groupModel.toJson());

      return true;
    } catch (e) {}
  }

////////////// this is used to get group///////////////
  Stream<QuerySnapshot>? getCreateGroup() {
    try {
      Stream<QuerySnapshot> snapshot =
          firebaseFireStore.collectionGroup("Group").snapshots();
      print("Successfully Fetched");
      return snapshot;
    } catch (e) {}
  }

///////////this used to update group/////
  updateGroup(GroupModel groupModel) async {
    try {
      await firebaseFireStore
          .collection("Group")
          .doc(groupModel.groupId)
          .update(groupModel.toJson());
    } catch (e) {
      print('Exception@UpdateGroups=>$e');
    }
  }

//////////// send group messages////////
  sendGroupMessage(GroupConversationModel groupConversationModel, var groupId) {
    try {
      firebaseFireStore
          .collection("Group")
          .doc(groupId)
          .collection("GroupMessages")
          .doc()
          .set(groupConversationModel.toJson());

      return true;
    } catch (e) {}
  }
//////////// Send Messages
  ///

  sendMessage(FriendMessageModel friendMessageModel, var friendId) {
    try {
      firebaseFireStore
          .collection("Conversation")
          .doc(locator<AuthServices>().appUser.appUserId)
          .collection("Chats")
          .doc(friendId)
          .collection("Messages")
          .add(friendMessageModel.toJson());

      firebaseFireStore
          .collection("Conversation")
          .doc(friendId)
          .collection("Chats")
          .doc(locator<AuthServices>().appUser.appUserId)
          .collection("Messages")
          .add(friendMessageModel.toJson());
      return true;
    } catch (e) {}
  }

  //// Add Friend

  addFriends(AddFriendModel addFriendModel, AddFriendModel currentUser) async {
    try {
      await firebaseFireStore
          .collection("Friends")
          .doc(addFriendModel.addById)
          .collection("friendList")
          .doc(addFriendModel.friendId)
          .set(addFriendModel.toJson());

      await firebaseFireStore
          .collection("Friends")
          .doc(currentUser.addById)
          .collection("friendList")
          .doc(currentUser.friendId)
          .set(currentUser.toJson());
    } catch (e) {}
  }
  //// Get Friends

  Future<List<AddFriendModel>> getFriends() async {
    final List<AddFriendModel> addFriendList = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Friends')
          .doc(locator<AuthServices>().appUser.appUserId)
          .collection('friendList')
          .get();
      if (snapshot.docs.length > 0) {
        snapshot.docs.forEach((element) {
          addFriendList.add(AddFriendModel.fromjson(element, element.id));
          print("GetAllFriends => ${element['friendName']}");
        });
      } else {
        print("No data found");
      }
    } catch (e) {
      print('Exception @DatabaseService/GetAllFriends $e');
    }
    return addFriendList;
  }

  /////////////////////////this is used to get selected user//////////
//   Future getSelectedUser(String? members) async {
//     try {
//       await firebaseFireStore
//           .collection("Group")
//           .doc(members)
//           .get()
//           .then((Snapshot snapshot) {
//         print(snapshot.data['members']);
//       });
// ;

//     } catch (e) {}
//   }

  Stream<QuerySnapshot>? getSelectedUserr() {
    try {
      Stream<QuerySnapshot> snapshot =
          firebaseFireStore.collection('Groups').snapshots();

      print("members fetch");
      return snapshot;
    } catch (e) {
      print("Error@memberList error ===> $e");
      // return "Error: $e";
      return null;
    }
  }

/////////\
  ///Add to watch/////////////
  ///
  ///
  ///
  firebaseMovieFetching(
      {required FireBaseMovieModel fireBaseMovieModel,
      final resultId,
      // final movieName
      final userId}) async {
    try {
      await firebaseFireStore
          .collection("Movies")
          .doc(resultId)
          .collection("AddBy")
          .doc(userId)
          .set(fireBaseMovieModel.toJson()
              // {'title': movieName, 'userId': userId}
              );

      return true;
    } catch (e) {
      print(e);
    }
  }

  ////////////
  ///
  ///get movie fetching
  ///

  Stream<QuerySnapshot>? getFirebaseMovie(final resultId) {
    try {
      Stream<QuerySnapshot> snapshot = firebaseFireStore
          .collection('Movies')
          .doc(resultId)
          .collection("AddBy")
          .snapshots();

      print("Successfully Fetched");
      snapshot.listen((event) {
        print(event.docs);
      });
      return snapshot;
    } catch (e) {
      print("Error@getmovie ===> $e");
      // return "Error: $e";
      //return null;
    }
  }

//////////////
  ///add movie review
  ///

  addfirebaseMoviereview({
    required MoviesReview moviesReview,
    final resultId,
  }) async {
    try {
      await firebaseFireStore
          .collection("Reviews")
          .doc(resultId.toString())
          .collection("AddBy")
          .doc(moviesReview.userId)
          .set(moviesReview.toJson());
    } catch (e) {
      print(e);
    }
  }

///////////
  /// get movie review
  ///

  Stream<QuerySnapshot>? getFirebaseMovieReviews(final resultId) {
    try {
      Stream<QuerySnapshot> snapshot = firebaseFireStore
          .collection('Reviews')
          .doc(resultId.toString())
          .collection("AddBy")
          .snapshots();

      print("Successfully Fetched");
      snapshot.listen((event) {
        print(event.docs);
      });
      return snapshot;
    } catch (e) {
      print("Error@getmoviereview ===> $e");
      // return "Error: $e";
      //return null;
    }
  }

///////////////////
  ///add to read
  ///
  firebaseBookFetching(
      {required FirebaseBookModel firebaseBookModel,
      final resultId,
      // final movieName
      final userId}) async {
    try {
      await firebaseFireStore
          .collection("Books")
          .doc(resultId)
          .collection("AddBy")
          .doc(userId)
          .set(firebaseBookModel.toJson()
              // {'title': movieName, 'userId': userId}
              );

      return true;
    } catch (e) {
      print(e);
    }
  }
//////
  ///get book fetching
  ///

  Stream<QuerySnapshot>? getFirebaseBook(final resultId) {
    try {
      Stream<QuerySnapshot> snapshot = firebaseFireStore
          .collection('Books')
          .doc(resultId)
          .collection("AddBy")
          .snapshots();

      print("Successfully Fetched");
      return snapshot;
    } catch (e) {
      print("Error@getfirebasebook ===> $e");
      // return "Error: $e";
      return null;
    }
  }

  ///
  /// add to listen
  ///

  firebaseMusicFetching(
      {required FirebaseMusicModel firebaseMusicModel,
      final resultId,
      // final movieName
      final userId}) async {
    try {
      await firebaseFireStore
          .collection("Music")
          .doc(resultId)
          .collection("AddBy")
          .doc(userId)
          .set(firebaseMusicModel.toJson()
              // {'title': movieName, 'userId': userId}
              );

      return true;
    } catch (e) {
      print(e);
    }
  }

  ///
  /// get music fetching
  ///

  Stream<QuerySnapshot>? getFirebasemusic(final resultId) {
    try {
      Stream<QuerySnapshot> snapshot = firebaseFireStore
          .collection('Music')
          .doc(resultId.toString())
          .collection("AddBy")
          .snapshots();

      print("Successfully Fetched");
      return snapshot;
    } catch (e) {
      print("Error@getfirebasemusic ===> $e");
      // return "Error: $e";
      return null;
    }
  }

//////set home field
  ///
  ///

  setActivity({required ActivityModel activityModel, final resultId}) async {
    try {
      await firebaseFireStore
          .collection("Activity")
          .doc(resultId)
          .set(activityModel.toJson());

      return true;
    } catch (e) {}
  }

  ////////
  ///get activity
  ///

  Stream<QuerySnapshot>? getActivity() {
    try {
      Stream<QuerySnapshot> snapshot =
          firebaseFireStore.collection('Activity').snapshots();

      print("Successfully Fetched");
      return snapshot;
    } catch (e) {
      print("Error@getactivity ===> $e");
      // return "Error: $e";
      return null;
    }
  }

  // Stream<QuerySnapshot>? getFriendRequest(String userId) {
  //   try {
  //     Stream<QuerySnapshot> snapshot = firebaseFireStore
  //         .collection('FriendRequests')
  //         .doc(userId)
  //         .collection("setRequest")
  //         .snapshots();

  //     print("Successfully Fetched");
  //     return snapshot;
  //   } catch (e) {
  //     print("Error@getFriendRequest ===> $e");
  //     // return "Error: $e";
  //     return null;
  //   }
  // }

//////this is used to add friends//////////////
  // Future addFriend({
  //   required AppUser senderInfo,
  //   required String currentUserId,
  // }) async {
  //   try {
  //     await firebaseFireStore
  //         .collection('Friends')
  //         .doc(currentUserId)
  //         .collection("FriendList")
  //         .doc(senderInfo.appUserId)
  //         .set(senderInfo.toJson());

  //     return true;
  //   } catch (e) {
  //     print('Exception@ requests=>$e');
  //     return e;
  //   }
  // }

  //////this is used to delete friends//////////////
  Future deleteFrindRequest({
    required String senderId,
    required String currenAppUser,
  }) async {
    try {
      await firebaseFireStore
          .collection('FriendRequests')
          .doc(currenAppUser)
          .collection("setRequest")
          .doc(senderId)
          .delete();

      return true;
    } catch (e) {
      print('Exception@ requests=>$e');
      return e;
    }
  }

/////// this is used to get friends /////////////////////////
  ///
  ///
  // Stream<QuerySnapshot>? getFriends(String userId) {
  //   try {
  //     Stream<QuerySnapshot> snapshot = firebaseFireStore
  //         .collection('Friends')
  //         .doc("${userId}")
  //         .collection("FriendList")
  //         .snapshots();

  //     print("data fetch");
  //     return snapshot;
  //   } catch (e) {
  //     print("Error@getFriend ===> $e");
  //     // return "Error: $e";
  //     return null;
  //   }
  // }

  // Future<List<FriendsModel>> getFriends(String userId) async {
  //   print("caaaaaaaaled");

  //   final List<FriendsModel> friendList = [];
  //   try {
  //     print("is it running");
  //    QuerySnapshot snapshot= await firebaseFireStore.collection('AppUser').get();
  //     // QuerySnapshot snapshot =

  //     // await FirebaseFirestore.instance
  //     //     .collection('Friends')
  //     //     .doc("qoyjeAh9YNho6GiEDFs8UQxex8I3")
  //     //     .collection("FriendList")
  //     //     .get();
  //     if (snapshot.docs.length > 0) {
  //       print("is it runnnnnnning =======================>");
  //       snapshot.docs.forEach((element) {
  //         friendList.add(FriendsModel.fromJson(element, element.id));
  //         print("getUser => ");
  //       });
  //     } else {
  //       print("No data found");
  //     }
  //   } catch (e) {
  //     print('Exception @DatabaseService/yyyyyy $e');
  //   }
  //   return friendList;
  // try {
  //   var result = await firebaseFireStore
  //       .collection('Friends')
  //       .doc(userId)
  //       .collection("setFriends")
  //       .get();
  //   // print("${result.docs.first.data()}");
  //   return result.docs;
  // } catch (e) {
  //   print("Error@getFriendRequest ===> $e");
  //   // return "Error: $e";
  //   return e;
  // }
}
//////////////// this is

//
// setWeight(WeightTracking weightTracking) async {
//   try{
//
//     await firebaseFireStore.collection("WeightTracking").doc(weightTracking.appUserId)
// .collection("setWeight").doc().set(weightTracking.toJson());
//
//   } catch (e){
//     print('Exception@WeightTracking=>$e');
//
//   }
//
//
// }
//
//
// Stream<QuerySnapshot>? getWeeklyWeight(String userId){
//
//   try {
//     Stream<QuerySnapshot> snapshot = firebaseFireStore
//         .collection('WeightTracking')
//         .doc(userId)
//         .collection('setWeight').
//         .snapshots();
//     print("Successfully Fetched");
//     return snapshot;
//   } catch (e) {
//     print('Exception@ GetWeeklyWeight ==> $e');
//     return null;
//   }
//
// }
//
// setKickCounter(KickCounterModel kickCounterModel)async{
//
//   try{
//     await firebaseFireStore.collection("KickCounting").doc(kickCounterModel.appUserId)
//         .collection("setKickCounting").doc().set(kickCounterModel.toJson());
//   //
//
//   }catch (e){
//     print('Exception@KickCounter=>$e');
//   }
// }
// endKickCounter(KickCounterModel kickCounterModel) async {
//
//   try{
//     await firebaseFireStore.collection("KickCounting").doc(kickCounterModel.appUserId)
//         .collection("setKickCounting").doc(DateFormat('dd-MM-yyyy').format(DateTime.now())).collection("SetKickCountingData").doc().set(kickCounterModel.toJson());
//
//   }catch (e){
//     print('Exception@KickCounter=>$e');
//   }
//
// }
//
//
//
// setCalenderData(CalenderModel calenderModel) async {
//
//   try{
//
//     await firebaseFireStore.collection("CalenderData").doc(calenderModel.appUserId).collection("SetCalende").doc().set(calenderModel.toJson());
//
//   }catch (e){
//     print('Exception@Calender=>$e');
//
//   }
// }
//
//
// Stream<QuerySnapshot>? getCalenderData(String userId){
//   try {
//     Stream<QuerySnapshot> snapshot = firebaseFireStore
//         .collection('CalenderData')
//         .doc(userId)
//         .collection('SetCalende').orderBy('selectedDate',descending: false).limit(36)
//         .snapshots();
//     print("Successfully Fetched");
//     return snapshot;
//   } catch (e) {
//     print('Exception@ GetWeeklyWeight ==> $e');
//     return null;
//   }
//
// }
//
//
// setBloodPressureData(BloodPressureModel bloodPressureModel) async {
//   try{
//
//     await firebaseFireStore.collection("BloodPressure").doc(bloodPressureModel.appUserId).collection("SetBloodPressure").doc().set(bloodPressureModel.toJson());
//
//   }catch (e){
//     print('Exception@BloodPressure=>$e');
//
//   }
//
// }
//
//
// Stream<QuerySnapshot>? getBloodPressure(String userId){
//
//   try {
//     Stream<QuerySnapshot> snapshot = firebaseFireStore
//         .collection('BloodPressure')
//         .doc(userId)
//         .collection('SetBloodPressure').orderBy('currentDate',descending: false).limit(36)
//         .snapshots();
//     print("Successfully Fetched");
//     return snapshot;
//   } catch (e) {
//     print('Exception@ GetWeeklyWeight ==> $e');
//     return null;
//   }
//
// }
//
//
// Stream<QuerySnapshot>? getHelpfulTip(){
//
//   try {
//     Stream<QuerySnapshot> snapshot = firebaseFireStore
//         .collection('HelpfulTips')
//         .orderBy('selectedDate',descending: false).limit(36)
//         .snapshots();
//     print("Successfully Fetched");
//     return snapshot;
//   } catch (e) {
//     print('Exception@ GetBloodPressure ==> $e');
//     return null;
//   }
//
// }
//
// setNoteData(AddNoteModel addNoteModel) async {
//   try{
//
//     await firebaseFireStore.collection("notesData").doc(addNoteModel.appUserId).collection("SetNotesData").doc().set(addNoteModel.toJson());
//
//   }catch (e){
//     print('Exception@addNoteData=>$e');
//
//   }
//
// }

// updateUserProfile(AppUser appUser) async {
//   try {
//     await firebaseFireStore
//         .collection('AppUser')
//         .doc(appUser.appUserId)
//         .update(appUser.toJson());
//   } catch (e) {
//     print('Exception@UpdateUserProfile=>$e');
//   }
// }
//
// ///
// /// Update first login value
// ///
// updateFirstLoginValue(AppUser appUser, String id) async {
//   try {
//     await firebaseFireStore.collection("AppUser").doc(id).update(
//         appUser.toJson());
//   } catch (e) {
//     print('Exception @DatabaseService/updateFirstLoginValue $e');
//   }
// }
//
// ///
// /// get all app users
// ///
// Future<List<AppUser>> getAllAppUser() async {
//   final List<AppUser> appUserList = [];
//   try {
//     QuerySnapshot snapshot = await firebaseFireStore.collection('AppUser')
//         .where(
//         "userEmail", isNotEqualTo: locator<AuthServices>().appUser.userEmail)
//         .where('makeProfilePrivate', isEqualTo: false)
//         .get();
//     if (snapshot.docs.length > 0) {
//       snapshot.docs.forEach((element) {
//         appUserList.add(AppUser.fromJson(element, element.id));
//         print("getUser => ${element['userName']}");
//       });
//     } else {
//       print("No data found");
//     }
//   } catch (e) {
//     print('Exception @DatabaseService/GetAllUsers $e');
//   }
//   return appUserList;
// }
//
// ///
// /// get all app users
// ///
// Future<List<AppUser>> getAppUsers() async {
//   final List<AppUser> appUserList = [];
//   try {
//     QuerySnapshot snapshot = await firebaseFireStore.collection('AppUser')
//         .where('makeProfilePrivate', isEqualTo: false)
//         .get();
//     if (snapshot.docs.length > 0) {
//       snapshot.docs.forEach((element) {
//         appUserList.add(AppUser.fromJson(element, element.id));
//         print("getUser => ${element['userName']}");
//       });
//     } else {
//       print("No data found");
//     }
//   } catch (e) {
//     print('Exception @DatabaseService/GetAllUsers $e');
//   }
//   return appUserList;
// }
//
// ///
// /// add Questionnaires
// ///
// addQuestionnaires(QuestionnairesModel questionnairesModel, String id) async {
//   try {
//     await firebaseFireStore.collection('Questionnaires').doc(id).set(
//         questionnairesModel.toJson());
//   } catch (e) {
//     print('Exception @DatabaseService/addQuestionnaires $e');
//   }
// }
//
// ///
// /// update Questionnaires
// ///
// updateQuestionnaires(QuestionnairesModel questionnairesModel,
//     String userId) async {
//   try {
//     await firebaseFireStore.collection('Questionnaires').doc(userId).update(
//         questionnairesModel.toJson());
//   } catch (e) {
//     print('Exception @DatabaseService/updateQuestionnaires $e');
//   }
// }
//
// ///
// /// User basic Questions / App setup
// ///
// Future<QuestionnairesModel> getQuestionnaires(String id) async {
//   print('Questionnaires User id=> $id');
//   try {
//     final snapshot = await firebaseFireStore.collection('Questionnaires').doc(
//         id).get();
//     print('Questionnaires Data: ${snapshot.data()}');
//     return QuestionnairesModel.fromJson(snapshot.data(), snapshot.id);
//   } catch (e) {
//     print('Exception @DatabaseService/QuestionnairesData $e');
//     return QuestionnairesModel();
//   }
// }
//
//
// Future<bool> myCheckRecordFun(String id) async {
//   try {
//     var dateTime = DateTime.now();
//     var onlyDate = DateFormat('dd-MM-yyyy');
//     String formattedDate = onlyDate.format(dateTime).toString();
//     var existsDoc = await firebaseFireStore.collection("Journals").doc(id)
//         .collection("UserJournals").doc(formattedDate)
//         .get();
//
//     if (!existsDoc.exists) {
//       print("Document does not exist");
//       return false;
//     } else if (existsDoc.exists) {
//       print("doucoment exist ==");
//       print(
//           "Today record exists ==============================================");
//       return true;
//     }
//   } catch (e) {
//
//   }
//   return false;
// }
//
// ///
// /// Add user behaviours and score
// ///
// Future<bool> addUserBehaviour(String id, Behaviour behaviour) async {
//   var dateTime = DateTime.now();
//   var onlyDate = DateFormat('dd-MM-yyyy');
//   String formattedDate = onlyDate.format(dateTime).toString();
//
//   try {
//     var existsDoc = await firebaseFireStore.collection("Journals").doc(id)
//         .collection("UserJournals").doc(formattedDate)
//         .get();
//
//     print("Checking condition bro ========== " + "${existsDoc.exists}");
//
//     print("Here is the user ID: " + id);
//
//     if (!existsDoc.exists) {
//       await firebaseFireStore.collection("Journals").doc(id).collection(
//           "UserJournals").doc(formattedDate).set(behaviour.toJson());
//     } else if (existsDoc.exists) {
//       print(
//           "Today record exists ==============================================");
//       return true;
//     }
//   } catch (e) {
//     print('Exception @DatabaseService/addUserBehaviour$e');
//   }
//   return false;
// }
//
// ///
// /// Get user behaviour stream
// ///
//
// Stream<QuerySnapshot>? getUserBehaviourStream(String currentUserId) {
//   try {
//     Stream<QuerySnapshot> snapShot = firebaseFireStore
//         .collection("Journals")
//         .doc(currentUserId)
//         .collection("UserJournals")
//         .orderBy('addedAt', descending: true)
//         .snapshots();
//     return snapShot;
//   } catch (e) {
//     print("Exception@UserBehaviour$e");
//     return null;
//   }
// }
//
// Future<List<Behaviour>> getUserJournal(String uid) async {
//   final List<Behaviour> behaviourList = [];
//   print('User id for Journals: $uid');
//   try {
//     QuerySnapshot snapshot = await firebaseFireStore
//         .collection("Journals")
//         .doc(uid)
//         .collection("UserJournals")
//         .orderBy('addedAt', descending: true)
//         .get();
//     if (snapshot.docs.length > 0) {
//       snapshot.docs.forEach((DocumentSnapshot doc) {
//         behaviourList.add(Behaviour.fromJson(doc, doc.id));
//         print("Journals behaviours => ${doc['behaviours']}");
//         print("Journals score => ${doc['scores']}");
//       });
//     } else {
//       print('No data in the list');
//     }
//   } catch (e) {
//     print('Exception @DatabaseService/getUserBehaviour => $e');
//   }
//   return behaviourList;
// }
//
// Future<Behaviour> getTodayJournal(String uid, String docId) async {
//   Behaviour behaviour = Behaviour();
//   try {
//     final snapshot = await firebaseFireStore.collection('Journals').doc(uid)
//         .collection('UserJournals').doc(docId)
//         .get();
//     if (snapshot.exists) {
//       print('Today Journal : ${snapshot.data()}');
//       return Behaviour.fromJson(snapshot.data(), snapshot.id);
//     } else {
//       return behaviour;
//     }
//   } catch (e) {
//     print('Exception @DatabaseService/getTodayJournal $e');
//     return Behaviour();
//   }
// }
//
// ///
// /// get recent journal
// ///
// Future<List<Behaviour>> getRecentJournal(String uid) async {
//   List<Behaviour> behaviours = [];
//   try {
//     final snapshot = await firebaseFireStore.collection('Journals').doc(uid)
//         .collection('UserJournals').orderBy('addedAt', descending: true)
//         .limit(1)
//         .get();
//     if (snapshot.docs.length > 0) {
//       snapshot.docs.forEach((DocumentSnapshot doc) {
//         behaviours.add(Behaviour.fromJson(doc, doc.id));
//         print("Journals behaviours => ${doc['behaviours']}");
//         print("Journals score => ${doc['scores']}");
//       });
//     } else {
//       print('No data in the list');
//     }
//   } catch (e) {
//     print('Exception @DatabaseService/getRecentJournal $e');
//   }
//   return behaviours;
// }
//
// ///
// /// Edit User journal
// ///
// updateUserJournal(String userId, Behaviour behaviour) {
//   try {
//     firebaseFireStore
//         .collection('Journals')
//         .doc(userId)
//         .collection("UserJournals")
//         .doc(behaviour.behaviorId)
//         .update(behaviour.toJson());
//   } catch (e) {
//     print('Exception@ updateJournalData ==> $e');
//   }
// }
//
// ///====================================///
// ///============== chat ===============///
// ///===================================///
//
// addUserMessage(AppUser currentAppUser, String toUserId,
//     Conversation conversation, AppUser toAppUser) async {
//   try {
//     // await firebaseFireStore.collection("Conversations").doc("$fromUserId").set(appUser.toJson());
//     // await firebaseFireStore.collection("Conversations").doc("$fromUserId$toUserId").collection("Messages").add(conversation.toJson());
//     ///
//     /// From User message
//     ///
//     await firebaseFireStore
//         .collection("Conversations")
//         .doc("${currentAppUser.appUserId}")
//         .collection("Chats")
//         .doc("$toUserId")
//         .collection("messages")
//         .add(conversation.toJson());
//     await firebaseFireStore
//         .collection("Conversations")
//         .doc("${currentAppUser.appUserId}")
//         .collection("Chats")
//         .doc("$toUserId")
//         .set(toAppUser.toJson());
//
//     ///
//     /// to user message
//     ///
//     await firebaseFireStore
//         .collection("Conversations")
//         .doc("$toUserId")
//         .collection("Chats")
//         .doc("${currentAppUser.appUserId}")
//         .collection("messages")
//         .add(conversation.toJson());
//     await firebaseFireStore
//         .collection("Conversations")
//         .doc("$toUserId")
//         .collection("Chats")
//         .doc("${currentAppUser.appUserId}")
//         .set(currentAppUser.toJson());
//   } catch (e) {
//     print('Exception@sentUserMessage$e');
//   }
// }
//
// ///
// /// Get conversation users list
// ///
// Stream<QuerySnapshot>? getUserConversationList(AppUser appUser) {
//   try {
//     Stream<QuerySnapshot> snapshot = firebaseFireStore
//         .collection("Conversations")
//         .doc(appUser.appUserId)
//         .collection("Chats")
//         .orderBy('lastMessageAt', descending: false)
//         .snapshots();
//     return snapshot;
//   } catch (e) {
//     print('Exception@GetUserConversationList$e');
//     return null;
//   }
// }
//
// ///
// /// get user all messages
// ///
// // Future<List<Conversation>> getAllMessages(String currentUserId, String toUserId) async{
// //   final List<Conversation> chatList = [];
// //   print("FromUserId=> $currentUserId");
// //   print("ToUserId=> $toUserId");
// //   try{
// //     QuerySnapshot snapshot = await firebaseFireStore.collection("Conversations")
// //         .doc(currentUserId).collection("Chats").doc(toUserId)
// //         .collection("messages").orderBy('sentAt',descending: false).get();
// //     print("messages length => ${snapshot.docs.length}");
// //
// //     if(snapshot.docs.length > 0){
// //       snapshot.docs.forEach((element) {
// //         chatList.add(Conversation.formJson(element, element.id));
// //         print("Message => ${chatList[0].messageText}");
// //         print(element['messageText']);
// //         print(element.id);
// //       });
// //       print("Message obj => ${chatList[1]}");
// //     }else{
// //       print("No messages found");
// //     }
// //   }catch(e){
// //     print('Exception@GetUserMessages$e');
// //   }
// //   return chatList;
// // }
//
// ///
// /// Stream Messages
// ///
// ///
//
// Stream<QuerySnapshot>? getRealTimeChat(String currentUserId,
//     String toUserId) {
//   try {
//     Stream<QuerySnapshot> messageSnapshot = firebaseFireStore
//         .collection("Conversations")
//         .doc(currentUserId)
//         .collection("Chats")
//         .doc(toUserId)
//         .collection("messages")
//         .orderBy('sentAt', descending: true)
//         .snapshots();
//     return messageSnapshot;
//   } catch (e) {
//     print('Exception@GetUserMessagesStream=>$e');
//     return null;
//   }
// }
//
// ///
// /// Contact us
// ///
// addContactUsDetails(String userId, ContactModel contactModel) async {
//   try {
//     await firebaseFireStore
//         .collection('ContactUs')
//         .doc(userId)
//         .collection('UserContacts')
//         .add(contactModel.toJson());
//   } catch (e) {
//     print("Exception@addContactUsDetails => $e");
//   }
// }
//
// sendMessageToCoach(String userId, String message) async {
//   try {
//     await firebaseFireStore.collection('UserMessageToCoach').doc(userId).set(
//         {
//           'userId': userId,
//           'message': message,
//           'messageAt': DateTime.now(),
//         }
//     );
//   } catch (e) {
//     print("Exception@UserMessageToCoach => $e");
//   }
// }
//
// ///
// /// In App user feedback
// ///
// Future<bool> addUserFeedback(String userId, int rating,
//     String userFeedback) async {
//   bool isFeedbackAdded = false;
//   try {
//     await firebaseFireStore.collection('Feedback&Suggestions')
//         .doc(userId)
//         .collection('feedback')
//         .add(
//         {
//           'rating': rating,
//           'userFeedback': userFeedback,
//           'FeedbackAt': DateTime.now(),
//         }
//     );
//     isFeedbackAdded = true;
//   } catch (e) {
//     print("Exception@Feedback&Suggestions => $e");
//     isFeedbackAdded = false;
//   }
//   return isFeedbackAdded;
// }
//
//
// Future<AllJournals> getJournalsData() async {
//
//   List<AllJournals> getSetJournals = [];
//
//   try {
//     var snapshot = await FirebaseFirestore.instance.collection("AddingJournals").doc("9J92nJJiIyioiIdwyiMv").get();
//
//
//     return AllJournals.fromJson(snapshot.data(), snapshot.id);
//
//   } catch (e) {
//
//     return AllJournals();
//     // List.from(value.data()!['AddingJournals']).forEach((element) {
//     //   getSetJournals.add(element);
//     // })   print('Exception error here => $e');
//   }
//
// }
