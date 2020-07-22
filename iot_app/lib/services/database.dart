import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iot_app/models/alert.dart';
import 'package:iot_app/models/goods.dart';
import 'package:iot_app/models/notif.dart';
import 'package:iot_app/models/pred.dart';
import 'package:iot_app/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference designationCollection =
  Firestore.instance.collection('designation');

  Future updateUserData(String designation) async {
    return await designationCollection
        .document(uid)
        .setData({'designation': designation});
  }


  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid:uid,
      designation: snapshot.data['designation'],
    );
  }
  Stream<QuerySnapshot> get designation{
    return designationCollection.snapshots();
  }
  Stream<UserData> get userData{
    return designationCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }



  final Query notificationCollections =  Firestore.instance
      .collection('notifications').where('isViewed', isEqualTo: false);

  List<Notifications> _notifListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      // ignore: missing_return

        return Notifications(
          
          
          isViewed : doc.data['isViewed'] ?? false,
        rfid: doc.data['rfid'] ?? 0,
        status: doc.data['status'] ?? '',
        location: doc.data['location'] ?? [],
          timestamp: doc.data['timestamp'].toDate() ?? '',
      );

    }).toList();
  }


  Stream<List<Notifications>> get notifications {
    return notificationCollections.snapshots()
        .map(_notifListFromSnapshot);
  }

  final CollectionReference goodsCollection = Firestore.instance.collection('goods');

  //good list from snapshot
  List<Goods> _goodListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Goods(
        rfid: doc.data['rfid'] ?? 0,
        status: doc.data['status'] ?? '',
        temp: doc.data['temp'] ?? [],
        humidity: doc.data['humidity'] ?? [],
        location: doc.data['location'] ?? [],

      );
    }).toList();
  }


  Stream<List<Goods>> get goods{
    return goodsCollection.snapshots()
        .map(_goodListFromSnapshot);
  }


  final Query allnotificationscollection =  Firestore.instance
      .collection("notifications")
      .orderBy("timestamp");
  List<Notifications> _allnotifListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      // ignore: missing_return

      return Notifications(
        isViewed : doc.data['isViewed'] ?? false,
        rfid: doc.data['rfid'] ?? 0,
        status: doc.data['status'] ?? '',
        location: doc.data['location'] ?? [],
        timestamp: doc.data['timestamp'].toDate() ?? '',
      );

    }).toList();
  }
  Stream<List<Notifications>> get allnotifications {
    return allnotificationscollection.snapshots()
        .map(_allnotifListFromSnapshot);
  }


  //alerts
  final Query alertscoll =  Firestore.instance
      .collection('alerts').where('isSolved', isEqualTo: true);
  List<Alerts> _alertsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      // ignore: missing_return
      return Alerts(
        isSolved : doc.data['isSolved'] ?? false,
        rfid: doc.data['rfid'] ?? 0,
        status: doc.data['status'] ?? '',
        issue: doc.data['issue'] ?? '',
        timestamp: doc.data['timestamp'].toDate() ?? '',
      );

    }).toList();
  }
  Stream<List<Alerts>> get alerts {
    return alertscoll.snapshots()
        .map(_alertsListFromSnapshot);
  }

  final Query newalertscoll =  Firestore.instance
      .collection('alerts').where('isSolved', isEqualTo: false);

  List<Alerts> _newalertsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      // ignore: missing_return
      return Alerts(
        isSolved : doc.data['isSolved'] ?? false,
        rfid: doc.data['rfid'] ?? 0,
        status: doc.data['status'] ?? '',
        issue: doc.data['issue'] ?? '',
        timestamp: doc.data['timestamp'].toDate() ?? '',
      );

    }).toList();
  }
  Stream<List<Alerts>> get newalerts {
    return newalertscoll.snapshots()
        .map(_newalertsListFromSnapshot);
  }

  final CollectionReference predictionCollection = Firestore.instance.collection('prediction');

  List<Predic> _predicListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Predic(
        me: doc.data['me'] ?? '',
        ols: doc.data['ols'] ?? '',
        pa: doc.data['pa'] ?? '',
        pred: doc.data['pred'] ?? '',
        qos: doc.data['qos'] ?? '',
      );

    }).toList();
  }
  //Analysis
  Stream<List<Predic>> get prediction {
    return predictionCollection.snapshots()
    .map(_predicListFromSnapshot);
  }



}

