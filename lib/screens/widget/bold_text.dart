import 'package:flutter/material.dart';

class BoldTxtWidget extends StatelessWidget {
  final String titl;
  const BoldTxtWidget({required this.titl});

  @override
  Widget build(BuildContext context) {
    {
      return Text(
        titl,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
      );
    }
  }
}
