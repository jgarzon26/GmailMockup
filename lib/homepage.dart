import 'package:flutter/material.dart';
import 'message.dart';

/*Conversion for month */
const months = {
  1: "January",
  2: "February",
  3: "March",
  4: "April",
  5: "May",
  6: "June",
  7: "July",
  8: "August",
  9: "September",
  10: "October",
  11: "November",
  12: "December",
};

enum CurrentBox { inbox, sent, archive }

var colors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.amber,
  Colors.purple,
  Colors.pink
];

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final List<Message> inbox = [];
  final List<Message> sent = [];
  final List<Message> archive = [];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  /*Temporary Messages */
  Message one = Message(
      message: "Hello",
      sender: "helloworld@gmail.com",
      name: "World",
      color: colors[1],
      dateReceived: DateTime.now());
  Message two = Message(
      message: "Hello, universe!",
      sender: "hellouniv@gmail.com",
      name: "Universe",
      color: colors[4],
      dateReceived: DateTime.now());
  var currBox = CurrentBox.inbox.index;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      drawer: getDrawer(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Search',
                  prefixIcon: IconButton(
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          'A',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
          ),
          runBoxes(),
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

  Widget runBoxes() {
    Widget box = const Text("Empty");
    switch (currBox) {
      case 0:
        box = displayInbox(context);
        break;
      case 1:
        box = displaySent(context);
        break;
      case 2:
        box = displayArchive(context);
    }

    return box;
  }

/*Display Inbox */
  Widget displayInbox(BuildContext context) {
    if (widget.inbox.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text("Inbox is empty"),
        ),
      );
    }
    return Expanded(
      child: ListView(
        children: widget.inbox.map((Message mess) {
          return Dismissible(
              key: UniqueKey(),
              background: Container(
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: const [
                        Icon(Icons.archive),
                        Text(
                          'Archive',
                        ),
                      ],
                    ),
                  )),
              secondaryBackground: Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(Icons.delete),
                        Text(
                          'Trash',
                        ),
                      ],
                    ),
                  )),
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  setState(() {
                    widget.archive.add(mess);
                    widget.inbox.remove(mess);
                  });
                } else {
                  setState(() {
                    widget.inbox.remove(mess);
                  });
                }
              },
              child: InkWell(
                  onTap: () {},
                  child: Row(children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: mess.getColor,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${months[mess.getMonth]} ${mess.getDay}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            mess.getName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
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

/*Display Sent box */
  Widget displaySent(BuildContext context) {
    if (widget.sent.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text("Inbox is empty"),
        ),
      );
    }
    return Expanded(
      child: ListView(
        children: widget.sent.map((Message mess) {
          return Dismissible(
              key: UniqueKey(),
              child: InkWell(
                  onTap: () {},
                  child: Row(children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: mess.getColor,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${months[mess.getMonth]} ${mess.getDay}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            mess.getName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
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

/*Display Archive box */
  Widget displayArchive(BuildContext context) {
    if (widget.archive.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text("Inbox is empty"),
        ),
      );
    }
    return Expanded(
      child: ListView(
        children: widget.archive.map((Message mess) {
          return Dismissible(
              key: UniqueKey(),
              child: InkWell(
                  onTap: () {},
                  child: Row(children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: mess.getColor,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${months[mess.getMonth]} ${mess.getDay}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            mess.getName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
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

  Widget getDrawer(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        const DrawerHeader(
            child: Text(
          "Menu",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50,
          ),
        )),
        ListTile(
            leading: const Icon(Icons.inbox),
            title: const Text(
              "Inbox",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            onTap: () {
              setState(() {
                currBox = CurrentBox.inbox.index;
              });
              Navigator.pop(context);
            }),
        ListTile(
          leading: const Icon(Icons.send),
          title: const Text(
            "Sent",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          onTap: () {
            setState(() {
              currBox = CurrentBox.sent.index;
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.archive),
          title: const Text(
            "Archived",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          onTap: () {
            setState(() {
              currBox = CurrentBox.archive.index;
            });
            Navigator.pop(context);
          },
        ),
      ],
    ));
  }
}
