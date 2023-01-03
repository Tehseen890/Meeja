class MoviesReview {
  String? userId;
  String? userName;
  String? userImage;
  String? review;

  String? sentAt;

  MoviesReview({
    this.userId,
    this.userName,
    this.userImage,
    this.sentAt,
    this.review,
  });

  MoviesReview.formJson(json, id) {
    this.userId = json['userId'];
    this.userName = json['userName'];
    this.userImage = json['userImage'];
    this.sentAt = json['sentAt'];

    this.review = json['review'];
  }

  toJson() {
    return {
      'userId': this.userId,
      'userName': this.userName,
      'userImage': this.userImage,
      'sentAt': this.sentAt,
      'review': this.review
    };
  }
}
