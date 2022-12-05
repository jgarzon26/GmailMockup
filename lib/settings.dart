import 'package:flutter/material.dart';
import 'generalsettings.dart';

class Settings extends StatelessWidget {
  const Settings({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;

    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: const Text("Settings"),
      ),
      body: Column(children: [
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GeneralSettings()));
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: width,
                  height: 60,
                  child: const Text(
                    "General settings",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                )),
            InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: width,
                  height: 60,
                  child: Text(
                    email,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                )),
            InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: width,
                  height: 60,
                  child: const Text(
                    "Add account",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                )),
          ]),
    );
  }
}