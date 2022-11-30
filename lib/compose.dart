import 'package:flutter/material.dart';
import 'message.dart';

class ComposePage extends StatefulWidget{

  @override
  State<ComposePage> createState() => _ComposePageState();
}

class _ComposePageState extends State<ComposePage> {
  
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Compose"
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.attachment,
                ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.send,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
              ),
            ),
          ],
        ),
      ),
    );
  }

}