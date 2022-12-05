import 'package:flutter/material.dart';
import 'package:gmail_mockup/compose.dart';
import 'package:gmail_mockup/messagepage.dart';
import 'package:gmail_mockup/overlays.dart';
import 'months.dart';
import 'message.dart';
import 'settings.dart';

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

  late final String _email;

  HomePage(this._email, {super.key});
  final List<Message> inbox = [Message(message: "Test due this Monday.", subject: "Test Due", sender: "rem@gmail.com", name: "Rembrand Holmes", color: colors[0], dateReceived: DateTime.now())];
  final List<Message> sent = [];
  final List<Message> archive = [];
  final searchController = TextEditingController();

  void updateSentBox(Message message){
    sent.add(message);
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var currBox = CurrentBox.inbox.index;
  List<Message> searches = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      drawer: getDrawer(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: widget.searchController,
              onChanged: searchBox,
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
                      onTap: () {
                        Overlays(context).showAccountDetails(true, widget._email);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          widget._email.characters.first.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
          runBoxes(width),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ComposePage(widget._email, widget.updateSentBox)));
          }
        },
        child: const Icon(Icons.send),
      ),
      bottomNavigationBar: getBottomNav(),
    ));
  }

  Widget runBoxes(double width) {
    Widget box = const Text("Empty");
    switch (currBox) {
      case 0:
        box = displayInbox(context, width);
        break;
      case 1:
        box = displaySent(context, width);
        break;
      case 2:
        box = displayArchive(context, width);
    }

    return box;
  }

/*Search function */
  void searchBox(String query) {
    final searchedMail = widget.inbox.where((message) {
      final name = message.getName.toLowerCase();
      final input = query.toLowerCase();

      return name.contains(input);
    }).toList();

    setState(() => searches = searchedMail);
  }

/*Display Inbox */
  Widget displayInbox(BuildContext context, double width) {
    if (widget.inbox.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text("Inbox is empty"),
        ),
      );
    } else if (widget.searchController.text.isNotEmpty) {
      return Expanded(
        child: ListView(
          children: searches.map((Message mess) {
            return SizedBox(
                width: width,
                child: Dismissible(
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
                          searches.remove(mess);
                        });
                      } else {
                        setState(() {
                          searches.remove(mess);
                        });
                      }
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MessagePage(message: mess)));
                      },
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 60,
                              width: 60,
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
                              width: width * 0.6,
                              child: Column(
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
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    mess.getMessage,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 10,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ]),
                    )));
          }).toList(),
        ),
      );
    }
    return Expanded(
      child: ListView(
        children: widget.inbox.map((Message mess) {
          return SizedBox(
            width: width,
            child: Dismissible(
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MessagePage(message: mess)));
                    },
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 60,
                            width: 60,
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
                          const SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            width: width * 0.6,
                            child: Column(
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
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]))),
          );
        }).toList(),
      ),
    );
  }

/*Display Sent box */
  Widget displaySent(BuildContext context, double width) {
    if (widget.sent.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text("Sentbox is empty"),
        ),
      );
    } else if (widget.searchController.text.isNotEmpty) {
      return Expanded(
        child: ListView(
          children: searches.map((Message mess) {
            return SizedBox(
              width: width,
              child: Dismissible(
                  key: UniqueKey(),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MessagePage(message: mess)));
                      },
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 60,
                              width: 60,
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
                            Column(
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
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  mess.getMessage,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                          ]))),
            );
          }).toList(),
        ),
      );
    }
    return Expanded(
      child: ListView(
        children: widget.sent.map((Message mess) {
          return SizedBox(
            width: width,
            child: Dismissible(
                key: UniqueKey(),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MessagePage(message: mess)));
                    },
                    child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
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
                            Column(
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
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  mess.getMessage,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                          ]),
                    ))
          );
        }).toList(),
      ),
    );
  }

/*Display Archive box */
  Widget displayArchive(BuildContext context, double width) {
    if (widget.archive.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text("Inbox is empty"),
        ),
      );
    } else if (widget.searchController.text.isNotEmpty) {
      return Expanded(
        child: ListView(
          children: searches.map((Message mess) {
            return SizedBox(
              width: width,
              child: Dismissible(
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
                        searches.remove(mess);
                      });
                    } else {
                      setState(() {
                        searches.remove(mess);
                      });
                    }
                  },
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MessagePage(message: mess)));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Container(
                          height: 60,
                          width: 60,
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
                          width: width * 0.6,
                          child: Column(
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
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                mess.getMessage,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        )
                      ]))),
            );
          }).toList(),
        ),
      );
    }
    return Expanded(
      child: ListView(
        children: widget.archive.map((Message mess) {
          return SizedBox(
            width: width,
            child: Dismissible(
                key: UniqueKey(),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MessagePage(message: mess)));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              mess.getMessage,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 10,
                              ),
                            )
                          ],
                        ),
                      )
                    ]))),
          );
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
              widget.searchController.clear();
              setState(() {
                currBox = CurrentBox.inbox.index;
                searches.clear();
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
            widget.searchController.clear();
            setState(() {
              currBox = CurrentBox.sent.index;
              searches.clear();
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
            widget.searchController.clear();
            setState(() {
              currBox = CurrentBox.archive.index;
              searches.clear();
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text(
            "Settings",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Settings(email: widget._email,)));
          },
        )
      ],
    ));
  }

  Widget getBottomNav() {
    return BottomNavigationBar(items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.mail),
        label: 'Mail',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.meeting_room),
        label: 'Meet',
      ),
    ]);
  }
}
