import 'package:flutter/material.dart';

class CustomCard2 extends StatefulWidget {
  const CustomCard2({Key? key}) : super(key: key);

  @override
  State<CustomCard2> createState() => _CustomCard2State();
}

class _CustomCard2State extends State<CustomCard2> {
  bool _flag = true;
  @override
  Widget build(BuildContext context) {
    {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        // decoration: BoxDecoration(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 160,
                        width: 140,
                        decoration: new BoxDecoration(
                          //   color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage("assets/Rectangle 164.png"),
                            //  fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() => _flag = !_flag

                                    //Colors.orange;
                                    );
                              },
                              icon: Icon(
                                Icons.star,
                                color: _flag ? Colors.orange : Colors.grey,
                                //primary: _flag ? Colors.orange : Colors.grey,
                                size: 20,
                              )),
                          Text(
                            "100%",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        "34 Users Watched",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "Amet minim mollit non deserunt \nullamco est sit aliqua dolor do\namet sint.Velit officia consequat \nduis enim velit mollit...",
                          style: TextStyle(
                              color: Colors.grey, height: 1.5, fontSize: 12),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
