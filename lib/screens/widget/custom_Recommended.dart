import 'package:flutter/material.dart';
import 'package:meeja/screens/recommend_item/recommended_item_provider.dart';
import 'package:provider/provider.dart';

class CustomRecommended extends StatefulWidget {
  final title;
  final image1;
  final friendId;
  Function()? onpress;

  CustomRecommended({this.image1, this.title, this.onpress, this.friendId});

  @override
  State<CustomRecommended> createState() => CustomRecommendedState();
}

class CustomRecommendedState extends State<CustomRecommended> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecommendedItemProvider>(
      builder: (context, model, child) => Padding(
        padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 12),
        child: Row(
          children: <Widget>[
            // Checkbox(
            //   activeColor: orangeColor,
            //   shape: const RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(
            //           Radius.circular(6.0))), // Rounded Checkbox

            //   checkColor: Colors.white,
            //   value: model.checkBoxes[index],
            //   onChanged: (value) {
            //     model.changingCheckBox(index, value);
            //     // model.isChecked = value ?? true;
            //   },
            // ),
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
            Expanded(child: SizedBox()),
            // widget.value == true
            // ? IconButton(
            //     onPressed: widget.onpress,
            //     icon: Icon(
            //       Icons.person_add,
            //       color: Colors.orange,
            //     ))
            // : Icon(Icons.person_remove)
            TextButton(onPressed: widget.onpress, child: Text('Send'))
          ],
        ),
      ),
    );
  }
}
