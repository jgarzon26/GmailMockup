import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage1 extends StatefulWidget{

  @override
  State<LoginPage1> createState() => _LoginPage1State();
}

class _LoginPage1State extends State<LoginPage1>{

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
        body: Column(
          children: [
            Text("Google"),
            Text("Sign in"),
            Row(
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
            TextField(
              decoration: InputDecoration(
                hintText: "Email or phone",
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          child: Text(
            "Next",
          ),
        ),
      ),
    );
  }
}