class FirebaseBookModel {
  String? userId;
  String? userName;
  String? bookTitle;
  String? userImage;
  String? review;
  String? bookSubtitle;
  String? sentAt;

  FirebaseBookModel(
      {this.userId,
      this.userName,
      this.bookSubtitle,
      this.sentAt,
      this.bookTitle,
      this.userImage,
      this.review});

  FirebaseBookModel.formJson(json, id) {
    this.userId = json['userId'];
    this.bookSubtitle = json['bookSubtitle'];
    this.sentAt = json['sentAt'];
    this.userImage = json['userImage'];
    this.bookTitle = json['bookTitle'];
    this.userName = json['userName'];
    this.review = json['review'];
  }

  toJson() {
    return {
      'userId': this.userId,
      'bookSubtitle': this.bookSubtitle,
      'sentAt': this.sentAt,
      'userName': this.userName,
      'bookTitle': this.bookTitle,
      'userImage': this.userImage,
      'review': this.review
    };
  }
}
