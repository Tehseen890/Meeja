import 'package:meeja/core/models/app_user.dart';

class Groups {
  final title2;

  final image2;
  Groups(this.title2, this.image2);
}

List<Groups> groups = [
  Groups('Group1', ''),
  Groups('Group2', ''),
  Groups('Group3', ''),
  Groups('Group4', ''),
  Groups('Group5', ''),
  Groups('Group6', ''),
  Groups('Group7', ''),
  Groups('Group8', ''),
  Groups('Group9', ''),
  Groups('Group10', ''),
  Groups('Group11', ''),
  Groups('Group12', ''),
  Groups('Group13', ''),
];
List<Groups> groupsP = [
  Groups('Cameron Williamson', ''),
  Groups('Darlene Robertson', ''),
  Groups('Theresa Webb', ''),
  Groups('Jane Cooper', ''),
  Groups('Jane Cooper', ''),
  Groups('Kristin Watson', ''),
  Groups('Annette Black', ''),
];

class GroupModel {
  String? groupAdmin;
  String? groupName;
  List<dynamic>? members;
  List<dynamic>? memberName;
  String? groupId;

  GroupModel({
    this.groupName,
    this.members,
    this.groupAdmin,
    this.groupId,
    this.memberName,
  });

  GroupModel.formJson(json, id) {
    this.groupId = id;
    this.groupAdmin = json['groupAdmin'];
    this.groupName = json['groupName'];
    this.members = json['members'];
    this.memberName = json['memberName'];
  }

  toJson() {
    return {
      'groupName': this.groupName,
      'groupAdmin': this.groupAdmin,
      'members': this.members,
      'groupId': this.groupId,
      'memberName': this.memberName,
    };
  }
}
