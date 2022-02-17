// ignore_for_file: file_names

import 'package:chat_app/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendLocationController extends GetxController {
  TextEditingController name = TextEditingController();
  Future<void> addNewLocation(
      {required String longitude,
      required String latitude,
      required String altitude,
      required BuildContext context}) async {
    try {
      isloading = true;

      // User? currentuser = FirebaseAuth.instance.currentUser;

      if (name.text != null || name.text.isNotEmpty) {
        FirebaseFirestore.instance.collection("userLocation").doc().set({
          "Place Name": name.text,
          "Altitude": altitude,
          "Longitude": longitude,
          "Latitude": latitude,
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Location Added")));
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      isloading = false;
    }
  }
}
