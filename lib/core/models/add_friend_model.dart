class AddFriendModel {
  String? friendId;
  String? friendName;
  String? friendImage;
  String? addById;
  AddFriendModel({
    this.friendId,
    this.friendName,
    this.friendImage,
    this.addById,
  });

  AddFriendModel.fromjson(json, id) {
    this.friendId = json['friendId'];
    this.friendName = json['friendName'];
    this.friendImage = json['friendImage'];
    this.addById = json['addById'];
  }

  toJson() {
    return {
      'friendId': this.friendId,
      'friendName': this.friendName,
      'friendImage': this.friendImage,
      'addById': this.addById,
    };
  }
}
