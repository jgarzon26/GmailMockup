import 'package:flutter/material.dart';
import 'message.dart';

class SentBoxPage extends StatefulWidget{

  List<Widget> _messagesSent = [];

  @override
  State<SentBoxPage> createState() => _SentBoxPageState();
}

class _SentBoxPageState extends State<SentBoxPage>{

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Column(
        children: [
          ListTile(
            leading: Text(
              "Sent",
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.filter_list,
              ),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: ListView(
              children: widget._messagesSent,
            ),
          ),
        ],
      ),
    );
  }
}