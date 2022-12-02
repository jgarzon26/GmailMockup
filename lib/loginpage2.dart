import 'package:flutter/material.dart';

class LoginPage2 extends StatefulWidget{

  late final String _email;

  LoginPage2(this._email);

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  var _showPassword = false;

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Column(
        children: [
          Text("Google"),
          Text("Welcome"),
          ListTile(
            leading: Icon(
              Icons.perm_identity,
            ),
            title: Text(widget._email),
          ),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: _showPassword,
            decoration: InputDecoration(
              hintText: "Enter your password",
            ),
          ),
          ListTile(
            
          )
        ],
      ),
    );
  }
}