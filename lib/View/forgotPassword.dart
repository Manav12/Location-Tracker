// ignore_for_file: file_names, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:chat_app/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

TextEditingController name = TextEditingController();

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var height;
  var width;
  var heightMultiplier;
  var widthMultiplier;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    heightMultiplier = MediaQuery.of(context).size.height / 100;
    widthMultiplier = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        title: Text(
          "Location Tracker",
          style: TextStyle(
              color: Colors.white,
              fontSize: widthMultiplier * 5,
              fontFamily: bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height - 50,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textfeild(
                      isLast: true,
                      hintText: "Email",
                      widthMultiplier: widthMultiplier,
                      controller: name),
                  SizedBox(
                    height: 20,
                  ),
                  button(
                      color: Colors.blue,
                      widthMultiplier: widthMultiplier,
                      text: "Send Email",
                      texColor: white,
                      funtion: () async {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).requestFocus(FocusScopeNode());
                          if (isEmail(string: name.text)) {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                                email: name.text.trim());
                            name.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Email has been send to given email address")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Enter Valid Email")));
                          }
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
