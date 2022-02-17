// ignore_for_file: prefer_const_constructors

import 'package:chat_app/View/home.dart';

import 'package:chat_app/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

late UserCredential userCredential;

Future registerUser(
    {required String email,
    required String password,
    required String username,
    required BuildContext context}) async {
  try {
    isloading = true;
    userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    FirebaseFirestore.instance
        .collection("userData")
        .doc(userCredential.user!.uid)
        .set({
      "userName": username,
      "email": email,
      'userId': userCredential.user!.uid,
      "password": password,
    });

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("The account has been created")));

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return HomePage();
    }));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a strong password")));
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("The account already exist with this email")));
    }
  } catch (e) {
    isloading = false;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  } finally {
    isloading = false;
  }
}

Future loginUser(
    {required String email,
    required String password,
    required BuildContext context}) async {
  try {
    isloading = true;
    userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return HomePage();
    }));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No user found for this email")));
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Wrong password provided for this user")));
    }
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  } finally {
    isloading = false;
  }
}

Future resetPasswrod(
    {required String email, required BuildContext context}) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
}

Future signout({required BuildContext context}) async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
}
