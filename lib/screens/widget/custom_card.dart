import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final name;
  final image;
  final time;
  final review;
  CustomCard({this.name, this.image, this.review, this.time});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool _flag = true;
  @override
  Widget build(BuildContext context) {
    {
      return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(backgroundImage: widget.image
                    // AssetImage('assets/img7.png'),
                    ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 8, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                widget.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: 2,
                            // ),
                            Text(
                              widget.time,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.star,
                      //       color: orangeColor,
                      //       size: 12,
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(top: 8, right: 60),
                      //       child: Text(
                      //         'Good',
                      //         style:
                      //             TextStyle(fontSize: 15, color: orangeColor),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: Text(
                          widget.review,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
    }
  }
}
