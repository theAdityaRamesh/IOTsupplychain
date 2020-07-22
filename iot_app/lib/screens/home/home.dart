import 'package:flutter/material.dart';
import 'package:iot_app/homepk.dart';
import 'package:iot_app/screens/home/analysis.dart';
import 'package:iot_app/screens/notifs/newalerts.dart';
import 'package:iot_app/services/auth.dart';
import 'package:iot_app/screens/notifs/notificationsview.dart';
import 'package:iot_app/screens/home/billingform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iot_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:iot_app/services/database.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          return Scaffold(
            backgroundColor: Colors.red[50],
            appBar: AppBar(
              title: Text('24GoAT', style: TextStyle(color: Colors.orange,  fontFamily: 'Play', fontStyle: FontStyle.italic, fontSize: 25)),
              backgroundColor: Color.fromRGBO(52, 73, 94, 1),
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                    icon: Icon(Icons.announcement, color: Colors.white,),
                    label: Text('Alerts', style: TextStyle(color: Colors.white,  fontFamily: 'Play', fontWeight: FontWeight.bold)),
                    onPressed: ()  {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Expanded(child: NewAlertsView())),
                      );
                    }),
                FlatButton.icon(
                    icon: Icon(Icons.notifications_active, color: Colors.white,),
                    label: Text('', style: TextStyle(color: Colors.white,  fontFamily: 'Play', fontWeight: FontWeight.bold)),
                    onPressed: ()  {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Notificationsview()),
                      );
                    }),
              ],
            ),
            drawer: new Drawer(
              child: ListView(
                children: <Widget>[
                  new UserAccountsDrawerHeader(accountName: Text(userData.designation, style: TextStyle(fontFamily: 'Play', fontSize: 20.0),),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(52, 73, 94, 1)
                    ),
                    accountEmail: FutureBuilder(
                      future: FirebaseAuth.instance.currentUser(),
                      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data.email, style: TextStyle(fontFamily: 'Play', fontSize: 16.0),);
                        }
                        else {
                          return Text('Loading...');
                        }
                      },
                    ),
                    currentAccountPicture: GestureDetector(
                      child: new CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person,color: Colors.white,),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Home()));
                    },
                    child: ListTile(
                      title: Text('Feed', style: TextStyle(fontFamily: 'Play', fontSize: 20.0),),
                      leading: Icon(Icons.home, color: Colors.teal),

                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => AnalysisPage()));
                    },
                    child: ListTile(
                      title: Text('Analysis', style: TextStyle(fontFamily: 'Play', fontSize: 20.0),),
                      leading: Icon(Icons.equalizer, color: Colors.teal,),

                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Billing()));
                    },
                    child: ListTile(
                      title: Text('Billing', style: TextStyle(fontFamily: 'Play', fontSize: 20.0),),
                      leading: Icon(Icons.shopping_cart, color: Colors.teal,),

                    ),
                  ),

                  //Logout
                  InkWell(
                    onTap: ()
                      async {
                        await _auth.signOut();

                    },
                    child: ListTile(
                      title: Text('Logout', style: TextStyle(fontFamily: 'Play', fontSize: 20.0),),
                      leading: Icon(Icons.person, color: Colors.teal),

                    ),
                  ),

                ],
              ),
            ),
            body : HomePK(),
          );
        }
    );
  }
}