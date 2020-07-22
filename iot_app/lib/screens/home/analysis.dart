import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/models/pred.dart';
import 'package:iot_app/services/database.dart';
import 'package:provider/provider.dart';

class AnalysisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Predic>>.value(
        value: DatabaseService().prediction,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Analysis',style: TextStyle(fontFamily: 'Play'),),
            backgroundColor: Color.fromRGBO(52, 73, 94, 1),
          ),
          body: AList(),
        ),);
  }
}

class AList extends StatefulWidget {
  @override
  _AListState createState() => _AListState();
}

class _AListState extends State<AList> {
  @override
  Widget build(BuildContext context) {

    final prediction = Provider.of<List<Predic>>(context);
//    print(prediction.documents);

    return ListView.builder(
      itemCount: prediction.length,
      itemBuilder: (context, index) {
        return PredTile(predic: prediction[index]);
      },
    );
  }
}

class PredTile extends StatelessWidget {

  final Predic predic;
  PredTile({this.predic});



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
         SizedBox(
           height: 30,
         ),
        Image(
          image: AssetImage('assets/ml.png'),
        ),
          SizedBox(
            height: 30,
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Parameters Considered', style: TextStyle(fontFamily: 'Play', color: Color.fromRGBO(52, 73, 94, 1), fontSize: 22.0, fontWeight: FontWeight.w600 ),),
            ),
          ),


          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(left: 20.0, top: 20.0),
              child: Column(
                children: <Widget>[
                  Text('Management Effectiveness:          ${predic.me}', style: TextStyle(fontFamily: 'Play', color: Color.fromRGBO(52, 73, 94, 1), fontSize: 20.0, fontWeight: FontWeight.w300 ),),
                  SizedBox(height: 10,),
                  Text('Objective Logistic Capacity:           ${predic.ols}', style: TextStyle(fontFamily: 'Play', color: Color.fromRGBO(52, 73, 94, 1), fontSize: 20.0, fontWeight: FontWeight.w300 ),),
                  SizedBox(height: 10,),
                  Text('Price Advantage:                               ${predic.pa}', style: TextStyle(fontFamily: 'Play', color: Color.fromRGBO(52, 73, 94, 1), fontSize: 20.0, fontWeight: FontWeight.w300 ),),
                  SizedBox(height: 10,),
                  Text('Quality of Service:                             ${predic.qos}', style: TextStyle(fontFamily: 'Play', color: Color.fromRGBO(52, 73, 94, 1), fontSize: 20.0, fontWeight: FontWeight.w300 ),)
                ],

              ),),
            ),

          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
              child: Text('Prediction Score', style: TextStyle(fontFamily: 'Play', color: Colors.deepOrange, fontSize: 22.0, fontWeight: FontWeight.w600 ),),
            ),
          ),

          Text(
            '${predic.pred.substring(0,6)}',  style: TextStyle(fontFamily: 'Play', color: Colors.indigo[900], fontSize: 25.0, fontWeight: FontWeight.w600 ),
          ),

        ],


      ),
    );
  }
}
