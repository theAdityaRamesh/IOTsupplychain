import 'package:cloud_firestore/cloud_firestore.dart';

class Alerts {

  final int rfid;
  final String status;
  final bool isSolved;
  final String issue;
  final DateTime timestamp;
  Alerts({this.timestamp, this.isSolved, this.rfid, this.status,  this.issue});
}