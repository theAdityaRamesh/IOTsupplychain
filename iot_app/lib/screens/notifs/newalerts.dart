
import 'package:flutter/material.dart';
import 'package:iot_app/models/alert.dart';
import 'package:iot_app/models/notif.dart';
import 'package:iot_app/screens/notifs/alerts.dart';
import 'package:iot_app/services/database.dart';

import 'package:provider/provider.dart';
import 'package:iot_app/screens/notifs/newalertstile.dart';




class NewAlertsView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Alerts>>.value(
        value: DatabaseService().newalerts,
        child: Scaffold(
          appBar: AppBar(
            title : Text("Alerts",style: TextStyle(fontFamily: 'Play'),),
            backgroundColor: Color.fromRGBO(52, 73, 94, 1),
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                  icon: Icon(Icons.announcement, color: Colors.white,),
                  label: Text('Past', style: TextStyle(color: Colors.white,  fontFamily: 'Play', fontWeight: FontWeight.bold)),
                  onPressed: ()  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AlertsView()),
                    );
                  }),


            ],
          ),

          body : AlertList(),



      ),
    );
  }
}




class AlertList extends StatefulWidget {
  @override
  _AlertListState createState() => _AlertListState();
}

class _AlertListState extends State<AlertList> {
  @override
  Widget build(BuildContext context) {
    final alerts = Provider.of<List<Alerts>>(context) ?? [];
    //print(notifs.documents);
    if (alerts == []) {
      return new Container(
        child: Text("No new Alerts"),
      );
    }
    else {
      return ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          return NewAlertsTile(alert: alerts[index]);
        },
      );
    }
  }
}
