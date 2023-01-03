import 'package:flutter/material.dart';
import 'package:meeja/screens/add_friend/add_friend_provider.dart';
import 'package:provider/provider.dart';

class CustomFriend extends StatefulWidget {
  final title;
  final image1;
  final isAdded;
  Function()? onpress;
  AddFriend model = AddFriend();

  CustomFriend({
    this.image1,
    this.title,
    this.onpress,
    this.isAdded,
    required this.model,
  }) {}

  @override
  State<CustomFriend> createState() => CustomFriendState();
}

class CustomFriendState extends State<CustomFriend> {
  bool? status;
  @override
  void initState() {
    print("Enter inint State >>>>>>>>>>");
    status = Provider.of<AddFriend>(context, listen: false)
        .addFriendStatus(widget.isAdded);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: [
                CircleAvatar(
                  //backgroundColor: Color(0xffC60000),
                  backgroundImage: AssetImage(widget.image1),
                  radius: 23,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          //Expanded(child: SizedBox()),
          status == false
              ? IconButton(
                  onPressed: widget.onpress,
                  icon: Icon(
                    Icons.person_add,
                    color: Colors.orange,
                  ))
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.person,
                    color: Colors.blue[200],
                  ),
                )
        ],
      ),
    );
  }
}
