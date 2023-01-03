class FirebaseMusicModel {
  String? userId;
  String? userName;
  String? musicTitle;
  String? userImage;
  String? review;
  String? musicSubtitle;
  String? sentAt;

  FirebaseMusicModel(
      {this.userId,
      this.userName,
      this.musicSubtitle,
      this.sentAt,
      this.musicTitle,
      this.userImage,
      this.review});

  FirebaseMusicModel.formJson(json, id) {
    this.userId = json['userId'];
    this.musicSubtitle = json['musicSubtitle'];
    this.sentAt = json['sentAt'];
    this.userImage = json['userImage'];
    this.musicTitle = json['musicTitle'];
    this.userName = json['userName'];
    this.review = json['review'];
  }

  toJson() {
    return {
      'userId': this.userId,
      'musicSubtitle': this.musicSubtitle,
      'sentAt': this.sentAt,
      'userName': this.userName,
      'musicTitle': this.musicTitle,
      'userImage': this.userImage,
      'review': this.review
    };
  }
}
