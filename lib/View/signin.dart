// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:chat_app/View/signup.dart';
import 'package:chat_app/common.dart';
import 'package:chat_app/services/register.dart';
import 'package:flutter/material.dart';

TextEditingController name = TextEditingController();
TextEditingController password = TextEditingController();

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
        appBar: appbar(widthMultiplier),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: height - 50,
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
              child: isloading == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          textfeild(
                              hintText: "Email",
                              isLast: false,
                              widthMultiplier: widthMultiplier,
                              controller: name),
                          const SizedBox(
                            height: 8,
                          ),
                          textfeild(
                              isLast: true,
                              hintText: "Password",
                              widthMultiplier: widthMultiplier,
                              controller: password),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(
                                  color: white,
                                  fontFamily: medium,
                                  fontSize: widthMultiplier * 3.5),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          button(
                              color: Colors.blue,
                              widthMultiplier: widthMultiplier,
                              text: "Sign In",
                              texColor: white,
                              funtion: () {
                                if (_formKey.currentState!.validate()) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusScopeNode());
                                  loginUser(
                                      email: name.text,
                                      password: password.text,
                                      context: context);
                                }
                              }),
                          const SizedBox(
                            height: 8,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?",
                                  style: TextStyle(
                                      fontSize: widthMultiplier * 4,
                                      color: white,
                                      fontFamily: medium)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                    return SignUp();
                                  }));
                                },
                                child: Text(
                                  "Register Now",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: widthMultiplier * 4,
                                      color: white,
                                      fontFamily: medium),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ));
  }
}
