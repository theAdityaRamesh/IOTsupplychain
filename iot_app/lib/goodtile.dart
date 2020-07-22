import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:iot_app/models/goods.dart';
import 'package:iot_app/homepk.dart';
import 'package:iot_app/update_form.dart';
import 'package:iot_app/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class GoodTile extends StatefulWidget {

  final Goods good;
  GoodTile({this.good});

  @override
  _GoodTileState createState() => _GoodTileState();
}

class _GoodTileState extends State<GoodTile> {

  final _formKey = GlobalKey<FormState>();

  String _currentStatus;

  @override
  Widget build(BuildContext context) {

    //bottomsheets
//    void _showSettingsPanel(){
//      showModalBottomSheet(context: context, builder: (context){
//        return Container(
//          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
//          child: Column(
//            children: [
//              SizedBox(
//                height: 30.0,
//              ),
//
//              Center(
//                  child: Image(image: AssetImage('assets/status.png'))
//              ),
//
//              SizedBox(
//                height: 50.0,
//              ),
//
//              Text('${widget.good.status}',style: TextStyle(fontSize: 25.0, fontFamily: 'Play')),
//              SizedBox(
//                height: 50.0,
//              ),
//
//
//            ],
//          ),
//        );
//      });
//    }
    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child:  Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30.0),
                  Text(
                    'Update Status of Good',
                    style: TextStyle(fontSize: 20.0, fontFamily: 'Play', fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 60.0),
                  TextFormField(
                    initialValue: widget.good.status,
                    decoration: textInputDecoration2,
                    validator: (val) => val.isEmpty ? 'Please update status of delivery' : null,
                    onChanged: (val) => setState(() => _currentStatus = val),
                  ),
                  SizedBox(height: 60.0),
                  RaisedButton(
                      color: Colors.teal[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        print(_currentStatus);
                        Firestore.instance.collection('goods').document(widget.good.rfid.toString())
                            .updateData({'status' : _currentStatus});
                        Firestore.instance.collection('notifications').document(widget.good.rfid.toString())
                            .updateData({'status' : _currentStatus,'timestamp' : DateTime.now(),'isViewed' : false});
                      }
                  ),
                ],
              )
          ),
        );
      });
    }
    //bottom sheet2
    void _showSettingsPanel2(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),

              Center(
                child: Image(image: AssetImage('assets/temp.png'))
              ),

              SizedBox(
                height: 30.0,
              ),

              Text('Avg Reading: ${widget.good.temp[7]}',style: TextStyle(fontSize: 20.0, fontFamily: 'Play')),

              SizedBox(
                height: 50.0,
              ),


              new Sparkline(
              data: [widget.good.temp[0],widget.good.temp[1],widget.good.temp[2],widget.good.temp[3],widget.good.temp[4],widget.good.temp[5],widget.good.temp[6]],
              lineColor: Colors.black,
              fillMode: FillMode.below,
                fillGradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.red[800],Colors.orange[800], Colors.yellow[300]],
                ),
              pointsMode: PointsMode.all,
              pointSize: 7.0,
              pointColor: Colors.indigo,
            ),


            ],
          ),
        );
      });
    }

//bottom sheet3

    void _showSettingsPanel3(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),

              Center(
                  child: Image(image: AssetImage('assets/cloud.png'))
              ),

              SizedBox(
                height: 30.0,
              ),

              Text('Avg Reading: ${widget.good.humidity[7]}',style: TextStyle(fontSize: 20.0, fontFamily: 'Play')),

              SizedBox(
                height: 50.0,
              ),


              new Sparkline(
                data: [widget.good.humidity[0],widget.good.humidity[1],widget.good.humidity[2],widget.good.humidity[3],widget.good.humidity[4],widget.good.humidity[5],widget.good.humidity[6]],
                lineColor: Colors.black,
                fillMode: FillMode.below,
                fillGradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.indigo[800],Colors.blue[500], Colors.blue[200]],
                ),
                pointsMode: PointsMode.all,
                pointSize: 7.0,
                pointColor: Colors.deepOrange,
              ),


            ],
          ),
        );
      });
    }


    void _showSettingsPanel4(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Column(
            children: [
              SizedBox(
                height: 30.0,
              ),

              Center(
                  child: Image(image: AssetImage('assets/location.png'))
              ),

              SizedBox(
                height: 50.0,
              ),

              Text('${widget.good.location[0]}° N, ${widget.good.location[1]}° E ',style: TextStyle(fontSize: 25.0, fontFamily: 'Play')),
              SizedBox(
                height: 50.0,
              ),


            ],
          ),
        );
      });
    }


    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Expanded( child: Card(
        color: Color.fromRGBO(255, 128, 74, 0.8),
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:<Widget>[ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: Icon(Icons.local_mall, color: Colors.white,),
              backgroundColor: Color.fromRGBO(52, 73, 94, 1),
            ),
            title: Text('RFID No: ${widget.good.rfid}', style: TextStyle(fontFamily: 'Play', fontSize: 17.0, fontWeight: FontWeight.w700),),
            subtitle: Text('Status: ${widget.good.status}', style: TextStyle(fontFamily: 'Play', fontSize: 16.0, fontWeight: FontWeight.w700, color: Colors.indigo[900]),),
          ),
          Column(
            children: [Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.wb_sunny),
              color: Colors.teal,
              textColor: Colors.white,
              label: const Text('Temp'),
              onPressed: () => _showSettingsPanel2(),
            ), FlatButton.icon(
                icon: Icon(Icons.cloud),
                color: Colors.teal,
                textColor: Colors.white,
                label: const Text('Humidity'),
                onPressed: () => _showSettingsPanel3(),
              ),
            ],
            ),
          SizedBox(
            height: 5.0,
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.update),
                  color: Colors.teal,
                  textColor: Colors.white,
                  label: const Text('Status'),
                  onPressed: () => _showSettingsPanel(),
                ),
                FlatButton.icon(
                  icon: Icon(Icons.my_location),
                  color: Colors.teal,
                  textColor: Colors.white,
                  label: const Text('Location'),
                  onPressed: () => _showSettingsPanel4(),
                ),
              ],
            ),

            ],
),

      ],
        ),
      ),)
    );
  }
}
