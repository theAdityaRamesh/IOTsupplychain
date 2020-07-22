import 'package:flutter/material.dart';
import 'package:iot_app/models/user.dart';
import 'package:iot_app/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Wrapper extends StatelessWidget {
  final db = Firestore.instance;

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
