import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/models/alert.dart';

import 'package:iot_app/shared/constants.dart';


class AlertsTile extends StatefulWidget {

  final Alerts alert;
  AlertsTile({this.alert});

  @override
  _AlertsTileState createState() => _AlertsTileState();
}

class _AlertsTileState extends State<AlertsTile> {
  @override
  Widget build(BuildContext context) {

    //bottomsheets


    //bottom sheet2
    void _showSettingsPanel2(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child : Text('Good ${widget.alert.rfid} was facing the issue ${widget.alert.issue} at ${(widget.alert.timestamp.toString().substring(11,16))} on ${(widget.alert.timestamp.toString().substring(0,10))}.. Location : ${widget.alert.status}'),


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
              child: Icon(Icons.done, color: Colors.white,),
              backgroundColor: Color.fromRGBO(97, 153, 139, 1),
            ),
            title: Text('Good ${widget.alert.rfid}  ', style: TextStyle(fontFamily: 'Play', fontWeight: FontWeight.bold),),
            subtitle: Text('Issue Resolved', style: TextStyle(fontFamily: 'Play', fontSize: 16.0, fontWeight: FontWeight.w700, color: Colors.indigo[900])),
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
