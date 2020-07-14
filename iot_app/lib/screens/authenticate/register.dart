import 'package:flutter/material.dart';
import 'package:iot_app/services/auth.dart';
import 'package:iot_app/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  String designation = 'Manager';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
          backgroundColor: Colors.purple[400],
          elevation: 0.0,
          title: Text('Register In to 24goat'),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  widget.toggleView();
                },
                icon: Icon(Icons.person),
                label: Text('Sign-IN'))
          ]),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'email'),
                    validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    }),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'password'),
                  validator: (val) =>
                      val.length < 6 ? 'Enter an password 6+ chars long' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                DropdownButton<String>(
                  value: designation,
                  onChanged: (String newValue) {
                    setState(() {
                      designation = newValue;
                    });
                  },
                  items: <String>['Manager', 'Operator']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                RaisedButton(
                  color: Colors.green[700],
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password, designation);
                      if (result == null) {
                        setState(() =>
                            error = 'Please Supply A valid Email/Password');
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          )),
    );
  }
}
