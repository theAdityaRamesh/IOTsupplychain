
import 'package:flutter/material.dart';
import 'package:iot_app/models/alert.dart';
import 'package:iot_app/models/notif.dart';
import 'package:iot_app/screens/notifs/allnotifs.dart';
import 'package:iot_app/screens/notifs/newalerts.dart';
import 'package:iot_app/screens/notifs/newalertstile.dart';
import 'package:iot_app/services/database.dart';

import 'package:provider/provider.dart';
import 'package:iot_app/screens/notifs/NotificationsTile.dart';

import 'alerts.dart';


class Notificationsview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Notifications>>.value(
        value: DatabaseService().notifications,
        child: Scaffold(
          appBar: AppBar(

            title : Text("Notifications",style: TextStyle(fontFamily: 'Play'),),
            backgroundColor: Color.fromRGBO(52, 73, 94, 1),
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                  icon: Icon(Icons.notifications, color: Colors.white,),
                  label: Text('Past', style: TextStyle(color: Colors.white,  fontFamily: 'Play', fontWeight: FontWeight.bold)),
                  onPressed: ()  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllNotifications()),
                    );
                  }),


            ],
          ),
          body :Column(

              children: <Widget>[
//                NewAlertsView()
                Expanded(child: NotifList()),
              ],

          ),



      ),
    );
  }
}


class NotifList extends StatefulWidget {
  @override
  _NotifListState createState() => _NotifListState();
}

class _NotifListState extends State<NotifList> {
  @override
  Widget build(BuildContext context) {

    final notifs =  Provider.of<List<Notifications>>(context) ?? []  ;
    //print(notifs.documents);
    if(notifs == []){
      return new Container(
        child: Text("No new notifications"),
      );
    }
    else {


      return ListView.builder(
        itemCount: notifs.length,
        itemBuilder: (context, index) {
          return NotificationsTile(notif: notifs[index]);

        },

      );
    }
  }
}




