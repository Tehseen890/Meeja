class FriendMessageModel {
  String? messageText;
  String? sentAt;
  bool? isMessageRead;
  String? sender;
  String? imageUrl;
  String? senderName;

  int? type;

  FriendMessageModel({
    this.sentAt,
    this.isMessageRead,
    this.messageText,
    this.imageUrl,
    this.sender,
    this.type,
    this.senderName,
  });

  FriendMessageModel.formJson(json, id) {
    this.messageText = json['messageText'];
    this.sentAt = json['sentAt'];
    this.isMessageRead = json['isMessageRead'];
    this.sender = json['sender'];
    this.imageUrl = json['imageUrl'];
    this.type = json["type"];
    this.senderName = json['senderName'];
  }

  toJson() {
    return {
      'messageText': this.messageText,
      'sentAt': this.sentAt,
      'isMessageRead': this.isMessageRead,
      'sender': this.sender,
      'imageUrl': this.imageUrl,
      'type': this.type,
      'senderName': this.senderName,
    };
  }
}
