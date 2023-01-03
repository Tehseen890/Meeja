import 'package:flutter/material.dart';


// final textFiledContainerStyle = BoxDecoration(
//   color: Colors.grey[300],
//   borderRadius: BorderRadius.circular(7),
//   boxShadow: [
//     BoxShadow(
//       color: Colors.grey.withOpacity(0.3),
//       spreadRadius: 2,
//       blurRadius: 3,
//       offset: Offset(0, 2),
//     ),
//   ],
// );
final appBarShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    bottomRight: Radius.circular(7),
    bottomLeft: Radius.circular(7),
  ),
);
final searchFieldStyle = InputDecoration(
  hintText: 'Search here ...',
  contentPadding: EdgeInsets.all(10),
  filled: true,
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7), borderSide: BorderSide.none),
);