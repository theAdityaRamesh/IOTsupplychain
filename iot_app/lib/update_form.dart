import 'package:flutter/material.dart';
import 'package:iot_app/shared/constants.dart';

class UpdateForm extends StatefulWidget {
  @override
  _UpdateFormState createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {

  final _formKey = GlobalKey<FormState>();

  String _currentStatus;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Good Details',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Please update status of delivery' : null,
            onChanged: (val) => setState(() => _currentStatus = val),
          ),
          SizedBox(height: 10.0),
          RaisedButton(
              color: Colors.blueGrey[400],
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                print(_currentStatus);
              }
          ),
        ],
      )
    );
  }
}
