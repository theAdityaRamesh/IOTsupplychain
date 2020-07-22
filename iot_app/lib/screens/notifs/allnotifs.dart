
import 'package:flutter/material.dart';
import 'package:iot_app/models/alert.dart';
import 'package:iot_app/models/notif.dart';
import 'package:iot_app/screens/notifs/alerts.dart';
import 'package:iot_app/services/database.dart';

import 'package:provider/provider.dart';
import 'package:iot_app/screens/notifs/NotificationsTile.dart';

import 'alertstile.dart';
import 'allntile.dart';


class AllNotifications extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Notifications>>.value(
      value: DatabaseService().allnotifications,
      child: Scaffold(
        appBar: AppBar(
          title : Text("All Notifications",style: TextStyle(fontFamily: 'Play'),),
          backgroundColor: Color.fromRGBO(52, 73, 94, 1),
          elevation: 0.0,
          actions: <Widget>[


          ],
        ),
        body : Column(

      children: <Widget>[
//                NewAlertsView(),
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
          return AllNotificationsTile(notif: notifs[index]);

        },

      );
    }
  }
}


class AlertList extends StatefulWidget {
  @override
  _AlertListState createState() => _AlertListState();
}

class _AlertListState extends State<AlertList> {
  @override
  Widget build(BuildContext context) {

    final alerts =  Provider.of<List<Alerts>>(context) ?? []  ;
    //print(notifs.documents);
    if(alerts == []){
      return new Container(
        child: Text("No new notifications"),
      );
    }
    else {
      return ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          return AlertsTile(alert: alerts[index]);

        },
      );
    }
  }
}