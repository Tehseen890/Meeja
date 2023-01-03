class ActivityModel {
  List<dynamic>? userId;
  String? image;
  String? title;
  String? description;
  // String? author;
  String? type;
  String? itemId;

  String? rating;

  ActivityModel(
      {this.userId,
      this.title,
      this.itemId,
      this.type,
      //   this.author,
      this.rating,
      this.image,
      this.description});

  ActivityModel.formJson(json, id) {
    this.userId = json['userId'];
    this.title = json['title'];
    this.itemId = json['itemId'];

    this.rating = json['rating'];
    this.type = json['type'];
    //  this.author = json['author'];

    this.image = json['image'];
    this.description = json['description'];
  }

  toJson() {
    return {
      'description': this.description,
      'userId': this.userId,
      'type': this.type,
      //   'author': this.author,
      'itemId': this.itemId,
      'title': this.title,
      'rating': this.rating,
      'image': this.image,
    };
  }
}
