import 'package:flutter/material.dart';

class CustomSearch extends StatefulWidget {
  final title3;
  final image3;
  CustomSearch({this.title3, this.image3});

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: [
              Container(
                child: Image.asset("assets/book1.png"),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      widget.title3,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Morgan Housal",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: "(Author)",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 80),
                      child: Row(
                        children: [
                          IconButton(onPressed: () {}, icon: Icon(Icons.star)),
                          Text(
                            "100%",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
