class FireBaseMovieModel {
  String? userId;
  String? userName;
  String? movieTitle;
  String? userImage;
  String? review;
  String? movieDescription;
  String? sentAt;

  FireBaseMovieModel(
      {this.userId,
      this.userName,
      this.movieDescription,
      this.sentAt,
      this.movieTitle,
      this.userImage,
      this.review});

  FireBaseMovieModel.formJson(json, id) {
    this.userId = json['userId'];
    this.movieDescription = json['movieDescription'];
    this.sentAt = json['sentAt'];
    this.userImage = json['userImage'];
    this.movieTitle = json['movieTitle'];
    this.userName = json['userName'];
    this.review = json['review'];
  }

  toJson() {
    return {
      'userId': this.userId,
      'movieDescription': this.movieDescription,
      'sentAt': this.sentAt,
      'userName': this.userName,
      'movieTitle': this.movieTitle,
      'userImage': this.userImage,
      'review': this.review
    };
  }
}
