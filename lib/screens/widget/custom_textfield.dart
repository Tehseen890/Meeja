import 'package:flutter/material.dart';
import 'package:meeja/core/constants/colors.dart';

class customTextField extends StatelessWidget {
  final hinttext;
  final text;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  TextEditingController? controller;
  AutovalidateMode? autoValidateMode;
  final sufFixIcon;
  final textInputAction;
  final keyBoardType;
  final maxLine;

  customTextField({
    this.hinttext,
    this.onChanged,
    this.text,
    this.autoValidateMode,
    this.validator,
    this.controller,
    this.sufFixIcon,
    this.keyBoardType,
    this.textInputAction,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            text,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),

          // margin: EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            validator: validator,
            onChanged: onChanged,
            textInputAction: textInputAction,
            keyboardType: keyBoardType,
            controller: controller,
            // maxLines: maxLine,
            // minLines: ,
            autovalidateMode: autoValidateMode ?? AutovalidateMode.disabled,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              hintText: hinttext,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: orangeColor, width: 1.0),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff999999), width: 1.0),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff999999), width: 1.0),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
