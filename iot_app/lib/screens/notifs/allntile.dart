import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/models/notif.dart';

import 'package:iot_app/shared/constants.dart';


class AllNotificationsTile extends StatefulWidget {

  final Notifications notif;
  AllNotificationsTile({this.notif});

  @override
  _NotificationsTileState createState() => _NotificationsTileState();
}

class _NotificationsTileState extends State<AllNotificationsTile> {
  @override
  Widget build(BuildContext context) {

    //bottomsheets


    //bottom sheet2
    void _showSettingsPanel2(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child : Text('Good ${widget.notif.rfid} is ${widget.notif.status} at ${widget.notif.timestamp}'),


        );
      });
    }


    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
//        color: Color.fromRGBO(255, 128, 74, 0.6),
        color: Color.fromRGBO(221, 166, 146, 0.4),
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:<Widget>[ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: Icon(Icons.notifications, color: Colors.indigo[900],),
              backgroundColor: Colors.yellow,
            ),
            title: Text('Good ${widget.notif.rfid} ',style: TextStyle(fontFamily: 'Play', fontWeight: FontWeight.bold),),
            subtitle: Text('Status : ${widget.notif.status}',style: TextStyle(fontFamily: 'Play', fontSize: 16.0, fontWeight: FontWeight.w700, color: Colors.indigo[900])),
          ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[FlatButton(
                color: Colors.teal,
                textColor: Colors.white,
                child: const Text('Details'),
                onPressed: () => {
                  _showSettingsPanel2()
                },
              ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
