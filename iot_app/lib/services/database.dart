import 'package:cloud_firestore/cloud_firestore.dart';

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
}
