import 'package:flutter/material.dart';
import 'package:gmail_mockup/homepage.dart';

class LoginPage2 extends StatefulWidget{

  late final String _email;

  LoginPage2(this._email);

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  var _showPassword = false;
  IconData _showPasswordCheckbox = Icons.check_box_outline_blank;

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: Column(
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
              obscureText: _showPassword,
              decoration: InputDecoration(
                hintText: "Enter your password",
              ),
            ),
            ListTile(
              leading: IconButton(
                icon: Icon(
                  _showPasswordCheckbox,
                ),
                onPressed: () => setState(() => _showPasswordCheckbox = _showPassword ? Icons.check_box : Icons.check_box_outline_blank),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Forgot Password?"),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage())
            );
          },
          child: Text("Next"),
        ),
      ),
    );
  }
}