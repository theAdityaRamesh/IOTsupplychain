import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/models/user.dart';
import 'package:iot_app/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String des = '';

void getData(String des) async {
  final db = Firestore.instance;
  var firebaseUser = await FirebaseAuth.instance.currentUser();
  db
      .collection("designation")
      .document(firebaseUser.uid)
      .get()
      .then<dynamic>((DocumentSnapshot snapshot) {
    des = snapshot.data["designation"];
  });
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //returns Home or Sign IN
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
