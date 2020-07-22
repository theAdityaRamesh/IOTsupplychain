import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/models/alert.dart';
import 'package:iot_app/models/notif.dart';

import 'package:iot_app/shared/constants.dart';


class NewAlertsTile extends StatefulWidget {

  final Alerts alert;
  NewAlertsTile({this.alert});

  @override
  _NotificationsTileState createState() => _NotificationsTileState();
}

class _NotificationsTileState extends State<NewAlertsTile> {
  @override
  Widget build(BuildContext context) {

    //bottomsheets


    //bottom sheet2
    void _showSettingsPanel2(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child : Text('Clear  ${widget.alert.rfid} '),


        );
      });
    }


    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        color: Color.fromRGBO(255, 128, 74, 0.6),
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:<Widget>[ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: Icon(Icons.error, color: Colors.white,),
              backgroundColor: Colors.red,
            ),
            title: Text('An alert was recorded for Good ${widget.alert.rfid} at ${(widget.alert.timestamp.toString().substring(11,16))} on ${(widget.alert.timestamp.toString().substring(0,10))}.',style: TextStyle(fontFamily: 'Play', fontWeight: FontWeight.bold),),
            subtitle: Text('Status : ${widget.alert.status}',style: TextStyle(fontFamily: 'Play', fontSize: 16.0, fontWeight: FontWeight.w700, color: Colors.indigo[900])),
          ),

            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[FlatButton(
              color: Colors.teal,
              textColor: Colors.white,
              child: const Text('Solved'),
              onPressed: () => {
                Firestore.instance.collection('alerts').document(widget.alert.rfid.toString())
                    .updateData({'isSolved' : true})
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
