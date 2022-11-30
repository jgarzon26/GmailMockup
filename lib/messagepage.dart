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
            body: Column(
                children: [
          SizedBox(
            width: width,
            height: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_sharp))
              ],
            ),
          ),
          SizedBox(
            width: width,
            height: 30,
            child: Text(
              message.getSubject,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: width,
            height: 30,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: message.getColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
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
                  ],
                ),
                Text("${months[message.getMonth]} ${message.getDay}",),
              ],
            ),
          ),
          Expanded(
            child: Text(
              message.getMessage,
              style: const TextStyle(
                fontSize: 40,
              ),
            )
          )
        ])));
  }
}
