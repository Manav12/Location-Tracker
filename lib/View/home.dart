// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_typing_uninitialized_variables

import 'package:chat_app/Controller/sendData.dart';
import 'package:chat_app/common.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  SendLocationController _loadDataController =
      Get.put(SendLocationController());

  var height;
  var width;
  var heightMultiplier;
  var widthMultiplier;
  String latitide = "";
  String longitude = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    heightMultiplier = MediaQuery.of(context).size.height / 100;
    widthMultiplier = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appbar(widthMultiplier),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
        child: Center(
            child: isloading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GestureDetector(
                    onTap: () {
                      getCurrLoc();
                    },
                    child: Container(
                      height: heightMultiplier * 8,
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue),
                      child: Center(
                        child: isloading == true
                            ? const CircularProgressIndicator()
                            : Text(
                                "Save Location",
                                style: TextStyle(
                                    color: white,
                                    fontFamily: medium,
                                    fontSize: widthMultiplier * 5),
                              ),
                      ),
                    ))),
      ),
    );
  }

  Future<void> getCurrLoc() async {
    await addWeight(weight: _loadDataController.name);
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are denied');
    }
    try {
      isloading = true;
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        setState(() {
          _loadDataController.addNewLocation(
              context: context,
              altitude: position.altitude.toString(),
              longitude: position.longitude.toString(),
              latitude: position.latitude.toString());
        });
      }).catchError((e) {
        latitide = "";
        longitude = "";
      });
    } on Exception catch (e) {
    } finally {
      isloading = false;
    }
  }

  addWeight({
    required TextEditingController weight,
  }) {
    Widget okButton = TextButton(
        child: Text("Add"),
        onPressed: () async {
          FocusScope.of(context).requestFocus(FocusScopeNode());
          if (_formKey.currentState!.validate()) {
            Navigator.of(context).pop();
            await getCurrentLocation();

            weight.clear();
          }
          ;
        });

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Save New Position"),
      content: Container(
        height: 60,
        child: Form(
          key: _formKey,
          child: TextFormField(
            style: TextStyle(
              color: Colors.black,
              fontSize: widthMultiplier * 3,
            ),
            controller: weight,

            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Cannot be null';
              }
              return null;
            },

            // Only numbers can be entered

            decoration: InputDecoration(
              hintText: "Add new location",
              hintStyle: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
