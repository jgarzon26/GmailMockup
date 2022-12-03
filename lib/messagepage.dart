import 'package:flutter/material.dart';
import 'months.dart';
import "message.dart";

class MessagePage extends StatelessWidget {
  const MessagePage({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          width: width,
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.black),
          )),
          child: Text(
            message.getSubject,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.black),
          )),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: message.getColor,
                shape: BoxShape.circle,
              ),
              child: Text(  
                message.getName[0],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                message.getName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                message.getSender,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              )
            ]),
            Text(
              "${months[message.getMonth]} ${message.getDay}",
            ),
          ]),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView(
            children: [
              Text(
                message.getMessage,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
