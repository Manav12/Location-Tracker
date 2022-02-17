// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:chat_app/View/signin.dart';
import 'package:chat_app/common.dart';
import 'package:chat_app/services/register.dart';
import 'package:flutter/material.dart';

TextEditingController name = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var height;
  var width;
  var heightMultiplier;
  var widthMultiplier;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    height = MediaQuery.of(context).size.height;
    heightMultiplier = MediaQuery.of(context).size.height / 100;
    widthMultiplier = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      appBar: appbar(widthMultiplier),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height - 50,
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
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
                            isLast: false,
                            hintText: "Username",
                            widthMultiplier: widthMultiplier,
                            controller: name),
                        const SizedBox(
                          height: 8,
                        ),
                        textfeild(
                            isLast: false,
                            hintText: "Email",
                            widthMultiplier: widthMultiplier,
                            controller: email),
                        const SizedBox(
                          height: 8,
                        ),
                        textfeild(
                            isLast: true,
                            hintText: "Password",
                            widthMultiplier: widthMultiplier,
                            controller: password),
                        const SizedBox(
                          height: 13,
                        ),
                        button(
                            color: Colors.blue,
                            widthMultiplier: widthMultiplier,
                            text: "Sign Up",
                            texColor: white,
                            funtion: () {
                              if (_formKey.currentState!.validate()) {
                                // setState(() {
                                //   isloading = true;
                                // });
                                FocusScope.of(context)
                                    .requestFocus(FocusScopeNode());
                                if (email.text.isNotEmpty) {
                                  registerUser(
                                      email: email.text,
                                      password: password.text,
                                      username: name.text,
                                      context: context);
                                }
                              }
                            }),
                        const SizedBox(
                          height: 8,
                        ),
                        // button(
                        //     color: white,
                        //     texColor: Colors.black,
                        //     widthMultiplier: widthMultiplier,
                        //     text: "Sign up with Google",
                        //     funtion: () {}),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?",
                                style: TextStyle(
                                    fontSize: widthMultiplier * 4,
                                    color: white,
                                    fontFamily: medium)),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return SignIn();
                                }));
                              },
                              child: Text(
                                "Login Now",
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
                          height: 18,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
