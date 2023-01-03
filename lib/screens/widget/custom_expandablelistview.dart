// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:meeja/core/constants/colors.dart';

// class CustomExpansionTile extends StatefulWidget {
//   final title;
//   final svg;
//   const CustomExpansionTile({required this.title, this.svg});

//   @override
//   State<CustomExpansionTile> createState() => _CustomExpansionTileState();
// }

// class _CustomExpansionTileState extends State<CustomExpansionTile> {
//   bool expandFlag = false;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, right: 20),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15.0),
//           // color: orangeColor,
//         ),
//         child: ExpansionTile(
//           backgroundColor: orangeColor,
//           collapsedBackgroundColor: Color(0xffFEF6F5),
//           title: Row(
//             children: [
//               SvgPicture.asset(
//                 widget.svg,
//                 color: Color(0xff968E8C),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Text(widget.title),
//             ],
//           ),
//           children: [
//             Text("data"),
//             SizedBox(
//               height: 10,
//             ),
//             Text("data"),
//             SizedBox(
//               height: 10,
//             ),
//             Text("data"),
//             SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class ExpandableListView extends StatefulWidget {
// //   final String title;
// //   final svg;

// //   ExpandableListView({required this.title, this.svg});

// //   @override
// //   _ExpandableListViewState createState() => _ExpandableListViewState();
// // }

// // class _ExpandableListViewState extends State<ExpandableListView> {
// //   bool expandFlag = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: EdgeInsets.only(left: 30, right: 30),
// //       child: Container(
// //         decoration: BoxDecoration(
// //           color: Color.fromARGB(255, 230, 230, 230),
// //           borderRadius: BorderRadius.circular(30),
// //         ),
// //         margin: EdgeInsets.symmetric(vertical: 1.0),
// //         child: Column(
// //           children: <Widget>[
// //             Container(
// //               decoration: BoxDecoration(
// //                 color: expandFlag ? orangeColor : Color(0xffFEF6F5),
// //                 borderRadius: BorderRadius.circular(30),
// //               ),
// //               padding: EdgeInsets.symmetric(horizontal: 5.0),
// //               child: Padding(
// //                 padding: const EdgeInsets.only(left: 8.0),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: <Widget>[
// //                     SvgPicture.asset(
// //                       widget.svg,
// //                       color: Color(0xff968E8C),
// //                     ),
// //                     Text(
// //                       widget.title,
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         color: expandFlag ? Colors.white : Colors.black,
// //                       ),
// //                     ),
// //                     SizedBox(
// //                       width: 100,
// //                     ),
// //                     Row(
// //                       children: [
// //                         IconButton(
// //                             icon: Center(
// //                               child: Icon(
// //                                 expandFlag
// //                                     ? (Icons.arrow_forward_ios)
// //                                     : Icons.keyboard_arrow_down,
// //                                 color: expandFlag ? Colors.white : Colors.black,
// //                                 size: 20.0,
// //                               ),
// //                             ),
// //                             onPressed: () {
// //                               setState(() {
// //                                 expandFlag = !expandFlag;
// //                               });
// //                             }),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             ExpandableContainer(
// //               expanded: expandFlag,
// //               child: Container(
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.only(
// //                     bottomRight: Radius.circular(10),
// //                     bottomLeft: Radius.circular(10),
// //                   ),
// //                   color: Color.fromARGB(255, 230, 230, 230),
// //                 ),
// //                 child: Padding(
// //                   padding: const EdgeInsets.only(
// //                     top: 8.0,
// //                     left: 30,
// //                   ),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Expanded(child: Text("Watching")),
// //                       SizedBox(
// //                         height: 10,
// //                       ),
// //                       Expanded(child: Text("Watching")),
// //                       SizedBox(
// //                         height: 10,
// //                       ),
// //                       Expanded(child: Text("Watching")),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class ExpandableContainer extends StatelessWidget {
// //   final bool expanded;
// //   final double collapsedHeight;
// //   final double expandedHeight;
// //   final Widget child;

// //   ExpandableContainer({
// //     required this.child,
// //     this.collapsedHeight = 0.0,
// //     this.expandedHeight = 100.0,
// //     this.expanded = true,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     double screenWidth = MediaQuery.of(context).size.width;
// //     return AnimatedContainer(
// //       duration: Duration(
// //         milliseconds: 500,
// //       ),
// //       curve: Curves.easeInOut,
// //       width: 350,
// //       height: expanded ? expandedHeight : collapsedHeight,
// //       child: child,
// //     );
// //   }
// // }
