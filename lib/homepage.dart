import 'package:flutter/material.dart';
import 'message.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final List<Message> inbox = [];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Message one = Message(
      message: "Hello",
      sender: "helloworld@gmail.com",
      name: "World",
      dateReceived: DateTime.now());
  Message two = Message(
      message: "Hello, universe!",
      sender: "hellouniv@gmail.com",
      name: "Universe",
      dateReceived: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
              ),
            ),
          ),
          widget.inbox.isEmpty
              ? const Center(
                  child: Text("Inbox is empty"),
                )
              : displayInbox(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          {
            /*Temporary setstate for testing */
            setState(() {
              widget.inbox.add(one);
              widget.inbox.add(two);
            });
          }
        },
        child: const Icon(Icons.send),
      ),
    ));
  }

/*Display Inbox */
  Widget displayInbox(BuildContext context) {
    return Expanded(
      child: ListView(
        children: widget.inbox.map((Message mess) {
          return Dismissible(
              key: Key(widget.inbox.indexOf(mess).toString()),
              child: InkWell(
                  onTap: () {},
                  child: Row(children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        mess.getName[0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 50),
                    SizedBox(
                      width: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                mess.getName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${mess.getMonth}-${mess.getDay}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                          Text(
                            mess.getMessage,
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    )
                  ])));
        }).toList(),
      ),
    );
  }
}
