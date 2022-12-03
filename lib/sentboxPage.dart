import 'package:flutter/material.dart';
import 'message.dart';

class SentBoxPage extends StatefulWidget{

  List<ListTile> _messagesSent = [];

  @override
  State<SentBoxPage> createState() => _SentBoxPageState();
}

class _SentBoxPageState extends State<SentBoxPage>{

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Column(
        children: [
          ListTile(),
        ],
      ),
    );
  }
}