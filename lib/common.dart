// ignore_for_file: prefer_const_constructors

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool isEmail({required String string}) {
  // Null or empty string is invalid
  if (string == null || string.isEmpty) {
    return false;
  }

  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(string)) {
    return false;
  }
  return true;
}

Color shadow = const Color.fromRGBO(0, 0, 0, 0.2);
Color darkGrey = const Color(0xFF515254);
Color primaryColor = Colors.orange;
Color white = Colors.white;
Color backgroundColor = const Color(0xff1F1F1F);
bool isloading = false;
const String bold = "bold";
const String regular = "regular";
const String medium = "medium";

PreferredSizeWidget appbar(var widthMultiplier) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.blue[400],
    title: Text(
      "Location Tracker",
      style: TextStyle(
          color: Colors.white, fontSize: widthMultiplier * 5, fontFamily: bold),
    ),
  );
}

Widget textfeild(
    {var widthMultiplier,
    required bool isLast,
    required String hintText,
    required TextEditingController controller}) {
  return TextFormField(
    controller: controller,
    textInputAction:
        isLast == true ? TextInputAction.done : TextInputAction.next,
    validator: (value) {
      if (value == "" || value == null) {
        return "cannot be empty";
      }
      return null;
    },
    style: TextStyle(
        color: white, fontSize: widthMultiplier * 5, fontFamily: medium),
    decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: white)),
        hintText: hintText,
        hintStyle: TextStyle(
            color: white.withOpacity(0.5),
            fontSize: widthMultiplier * 4,
            fontFamily: regular)),
  );
}

Widget button(
    {required VoidCallback funtion,
    required Color color,
    required Color texColor,
    required String text,
    var widthMultiplier}) {
  return GestureDetector(
      onTap: funtion,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: color),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: texColor,
                fontFamily: medium,
                fontSize: widthMultiplier * 5),
          ),
        ),
      ));
}

showErrorDialog(
  Color glowColor,
  Color circleColor,
  Color iconColor,
  String errorTitle,
  String error,
  String confirmText,
  Function func,
) {
  Get.defaultDialog(
    confirm: GestureDetector(
      onTap: () {
        Get.back();
        if (func != null) {
          func();
        }
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            confirmText,
            style: TextStyle(
                color: Colors.white, fontFamily: medium, fontSize: 16),
          ),
        ),
      ),
    ),
    title: '',
    barrierDismissible: false,
    radius: 20.0,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AvatarGlow(
          glowColor: glowColor,
          endRadius: 80.0,
          duration: Duration(milliseconds: 1500),
          repeat: true,
          showTwoGlows: true,
          repeatPauseDuration: Duration(milliseconds: 100),
          child: Material(
            // Replace this child with your own
            elevation: 0,
            shape: CircleBorder(),
            child: CircleAvatar(
              backgroundColor: circleColor,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.location_disabled),
              ),
              radius: 40.0,
            ),
          ),
        ),
        Container(
          child: Text(
            errorTitle,
            style: TextStyle(
                color: Colors.black,
                fontFamily: medium,
                fontSize: 22,
                fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            error,
            style: TextStyle(
              fontSize: 15,
              fontFamily: medium,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 10,
        ),

        // Align(
        //     alignment: Alignment.bottomCenter,
        //     child: GestureDetector(
        //       onTap: () {
        //         Navigator.pop(ct);
        //         if (tryAgain) {
        //           func();
        //         }
        //       },
        //       child: Container(
        //         margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
        //         width: width,
        //         height: 50,
        //         decoration: BoxDecoration(
        //           color: primaryColor,
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //         child: Center(
        //           child: Text(
        //             buttonText,
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontFamily: font,
        //                 fontSize: 16),
        //           ),
        //         ),
        //       ),
        //     )),
      ],
    ),
  );
}
