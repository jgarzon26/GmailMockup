import 'package:flutter/material.dart';
import 'package:gmail_mockup/loginpage2.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage1 extends StatefulWidget{

  @override
  State<LoginPage1> createState() => _LoginPage1State();
}

class _LoginPage1State extends State<LoginPage1>{

  final _emailController = TextEditingController();

  void _launchUrl() async {
    final url = Uri.parse("https://r.mtdv.me/learnmore");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch learn more';
    }
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                child: Text(
                  "Google",
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
              const Align(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("with your Google Account. "),
                  TextButton(
                      onPressed: _launchUrl,
                      child: Text(
                        "Learn more",
                      ),
                  ),
                ],
              ),
              TextFormField(
                //keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email or phone",
                ),
              ),
              TextButton(
                  onPressed: _launchUrl,
                  child: Text(
                    "Forgot email?",
                  ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Create account",
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage2(_emailController.text))
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              "Next",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}