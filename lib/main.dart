import 'package:flutter/material.dart';
import 'package:gmail_mockup/homepage.dart';
import 'loginpage.dart';

main() => runApp(const MyApp());

/*
Placed this back because of potential other
useful properties.
*/
class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email Mockup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage1(),
    );
  }
}