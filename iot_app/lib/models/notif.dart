import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications {

  final int rfid;
  final String status;
  final List<dynamic> location;
  final bool isViewed;
  final DateTime timestamp;
  Notifications({this.timestamp, this.isViewed, this.rfid, this.status,  this.location});
}