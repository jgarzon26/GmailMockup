import 'package:flutter/material.dart';
import 'package:gmail_mockup/homepage.dart';

class LoginPage2 extends StatefulWidget{

  final String _email;

  const LoginPage2(this._email, {super.key});

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {

  static const double _paddingLeft = 10;

  var _showPassword = false;
  IconData _showPasswordCheckbox = Icons.check_box_outline_blank;

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Google",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            const Text(
              "Welcome",
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const Padding(
                    padding: EdgeInsets.only(right: 8, top: _paddingLeft),
                    child: Icon(Icons.perm_identity),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: _paddingLeft),
                    child: Text(widget._email),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextFormField(
                obscureText: !_showPassword,
                decoration: const InputDecoration(
                  hintText: "Enter your password",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: _paddingLeft),
              child: ListTile(
                leading: Icon(
                  _showPasswordCheckbox,
                ),
                onTap: () {
                  _showPassword = !_showPassword;
                  setState(() => _showPasswordCheckbox = _showPassword
                      ? Icons.check_box
                      : Icons.check_box_outline_blank);
                },
                horizontalTitleGap: 0,
                title: const Text("Show Password"),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: _paddingLeft + 10),
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Forgot Password?"),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: FloatingActionButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage(widget._email))
              );
            },
            child: const Text("Next"),
          ),
        ),
      ),
    );
  }
}