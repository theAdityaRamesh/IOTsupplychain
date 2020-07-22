import 'package:flutter/material.dart';
import 'package:iot_app/services/auth.dart';
import 'package:iot_app/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children:<Widget>[
            Image(
            image: AssetImage('assets/signin.png')),
            Column(
              children: <Widget>[Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 40.0,
                  ),

                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                            decoration: textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            }),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Password'),
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
                        ButtonTheme(
                          minWidth: 320.0,
                          height: 50.0,
                          child:RaisedButton(
                          color: Colors.teal, shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(color: Colors.green)
                            ),
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white,  fontSize: 17.0),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              dynamic result = await _auth.signInWithEmailAndPassword(
                                  email, password);
                              if (result == null) {
                                setState(() => error = 'Error Signing In');
                              }
                            }
                          },
                        ),),
                        SizedBox(
                          height: 10.0,
                        ),
                        FlatButton.icon(
                            onPressed: () {
                              widget.toggleView();
                            },
                            icon: Icon(Icons.person),
                            label: Text('Register',
                                style: TextStyle( fontSize: 17.0))),
                      ],
                    ),
                  )),
    ],
            ),
          ],
        ),

      );
  }
}
