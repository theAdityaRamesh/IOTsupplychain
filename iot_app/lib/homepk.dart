import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/models/goods.dart';
import 'services/database.dart';
import 'package:provider/provider.dart';
import 'package:iot_app/goodtile.dart';
import 'package:iot_app/shared/constants.dart';

class HomePK extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Goods>>.value(
        value: DatabaseService().goods,
        child: Scaffold(

        body : GoodList(),
      ),
    );
  }
}

class GoodList extends StatefulWidget {
  @override
  _GoodListState createState() => _GoodListState();
}

class _GoodListState extends State<GoodList> {
  @override
  Widget build(BuildContext context) {

    final goods = Provider.of<List<Goods>>(context);
    //print(goods.documents);
    print(goods);
    goods.forEach((good){
      print(good.rfid);
      print(good.status);
      print(good.temp);
      print(good.humidity);
      print(good.location);
    });

    return ListView.builder(
      itemCount: goods.length,
      itemBuilder: (context, index){
        return  GoodTile(good: goods[index]);
      },
    );
  }
}


