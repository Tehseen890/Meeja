import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUser extends ChangeNotifier {
  String? appUserId;
  String? userName;
  String? profileImage;
  String? userEmail;
  double? time;
  String? userLocation;
  String? fullName;
  String? description;
  String? lastMessage;
  bool? blockUser;

  String? password;
  String? confirmPassword;
  bool? isFirstLogin;
  DateTime? createdAt;
  DateTime? deliveryDate;
  double? initialWeight;
  String? monthYear;
  DateTime? lastEntry;
  int? dayStreak;
  String? imageUrl;
  String? lastMessageAt;

  double? zaps;
  double? faceCardNumber;

  AppUser({
    this.appUserId,
    this.profileImage,
    this.userEmail,
    this.lastMessage,
    this.lastMessageAt,
    this.imageUrl,
    this.userName,
    this.userLocation,
    this.fullName,
    this.dayStreak,
    this.description,
    this.password,
    this.blockUser,
    this.zaps,
    this.confirmPassword,
    this.isFirstLogin,
    this.createdAt,
    this.deliveryDate,
    this.initialWeight,
    this.monthYear,
    this.time,
    this.lastEntry,
    this.faceCardNumber,
  });

  AppUser.fromJson(json, id) {
    this.appUserId = id;
    this.confirmPassword = json['confirmPassword'];
    this.lastMessage = json['lastMessage'] ?? '';
    this.dayStreak = json['dayStreak'] ?? 0;
    this.lastMessageAt = json['lastMessageAt'];
    this.profileImage = json['profileImage'];
    this.userName = json['userName'] ?? '';
    this.userEmail = json['userEmail'];
    this.userLocation = json['userLocation'];
    this.password = json['password'];
    this.fullName = json['phoneNumber'] ?? '';
    this.description = json['description'] ?? '';
    this.blockUser = json['blockUser'];
    this.isFirstLogin = json['isFirstLogin'];
    this.createdAt = json['createdAt'].toDate();
    this.initialWeight = json['initialWeight'];
    this.monthYear = json['monthYear'];
    this.lastEntry = json['lastEntry'].toDate();
  }
  toJson() {
    return {
      'appUserId': this.appUserId,
      'profileImage': profileImage,
      'userName': this.userName,
      'userEmail': this.userEmail,
      'phoneNumber': this.fullName,
      'lastMessage': this.lastMessage,
      'lastMessageAt': this.lastMessageAt,
      'dayStreak': this.dayStreak,
      'password': this.password,
      'description': this.description,
      'isFirstLogin': this.isFirstLogin,
      'createdAt': this.createdAt,
      'deliveryDate': this.deliveryDate,
      'initialWeight': this.initialWeight,
      'monthYear': this.monthYear,
      'lastEntry': this.lastEntry,
      'userLocation': this.userLocation,
      'faceCardNumber': this.faceCardNumber,
      'confirmPassword': this.confirmPassword,
      'blockUser': this.blockUser
    };
  }
}
