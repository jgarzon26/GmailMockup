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
  final List<Message> inbox = [
    Message(
      message: "Test due this Monday.",
      subject: "Test Due",
      sender: "rem@gmail.com",
      name: "Rembrand Holmes",
      color: colors[0],
      dateReceived: DateTime.now(),
    ),
    Message(
      message: "Test due this Friday.",
      subject: "Test Due",
      sender: "ann@gmail.com",
      name: "Ann Holmes",
      color: colors[1],
      dateReceived: DateTime.now(),
    ),
    Message(
      message:
          "Hello. This is your mother speaking. Please buy me a new pair shoes",
      subject: "Your mother here and she needs a new pair of shoes",
      sender: "monique@gmail.com",
      name: "Monique Stevens",
      color: colors[3],
      dateReceived: DateTime.now(),
    ),
    Message(
      message:
          "Hey son, I am going to take you on a field trip next Sunday. Free up your schedule on that day.",
      subject: "Let's go somewhere",
      sender: "lester@gmail.com",
      name: "Lester Stevens",
      color: colors[1],
      dateReceived: DateTime.now(),
    ),
    Message(
      message:
          "Congratulations! You are the lucky winner of P100,000. Please claim it here in the office or have it forfeit.",
      subject: "Congratulations",
      sender: "ofL@gmail.com",
      name: "Office of the Lottery",
      color: colors[3],
      dateReceived: DateTime.now(),
    ),
    Message(
      message: "Let's hang out!",
      subject: "Hey bro!",
      sender: "ann@gmail.com",
      name: "Ann Stevens",
      color: colors[5],
      dateReceived: DateTime.now(),
    )
  ];
  final List<Message> sent = [];
  final List<Message> archive = [];
  final searchController = TextEditingController();

  void updateSentBox(Message message) {
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
    var height = size.height;
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      drawer: getDrawer(context, width, height),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        Overlays(context)
                            .showAccountDetails(true, widget._email);
                      },
                      child: CircleAvatar(
                        backgroundColor: colors[0],
                        child: Text(
                          widget._email.characters.first.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(4, 5, 0, 6),
            child: Text(
              "Primary",
              style: TextStyle(
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
          runBoxes(width),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ComposePage(widget._email, widget.updateSentBox)));
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
        child: Padding(
          padding: const EdgeInsets.all(5),
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
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: mess.getColor,
                                  maxRadius: 25,
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
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: width * 0.8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            mess.getName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 5, 0),
                                            child: Text(
                                              "${months[mess.getMonth]} ${mess.getDay}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                mess.getSubject,
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
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  Icons.star_border_outlined)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ))),
              );
            }).toList(),
          ),
        ),
      );
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
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
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: mess.getColor,
                                maxRadius: 25,
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
                              const SizedBox(width: 10),
                              SizedBox(
                                width: width * 0.8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          mess.getName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 5, 0),
                                          child: Text(
                                            "${months[mess.getMonth]} ${mess.getDay}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                mess.getSubject,
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
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.star_border_outlined)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ))),
            );
          }).toList(),
        ),
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
        child: Padding(
          padding: const EdgeInsets.all(5),
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
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: mess.getColor,
                                  maxRadius: 25,
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
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: width * 0.8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            mess.getName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 5, 0),
                                            child: Text(
                                              "${months[mess.getMonth]} ${mess.getDay}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                mess.getSubject,
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
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  Icons.star_border_outlined)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ))),
              );
            }).toList(),
          ),
        ),
      );
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
                                  builder: (context) =>
                                      MessagePage(message: mess)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: mess.getColor,
                                  maxRadius: 25,
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
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: width * 0.8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            mess.getName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 5, 0),
                                            child: Text(
                                              "${months[mess.getMonth]} ${mess.getDay}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                mess.getSubject,
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
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  Icons.star_border_outlined)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ))));
          }).toList(),
        ),
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
        child: Padding(
          padding: const EdgeInsets.all(5),
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
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: mess.getColor,
                                  maxRadius: 25,
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
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: width * 0.8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            mess.getName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 5, 0),
                                            child: Text(
                                              "${months[mess.getMonth]} ${mess.getDay}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                mess.getSubject,
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
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  Icons.star_border_outlined)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ))),
              );
            }).toList(),
          ),
        ),
      );
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
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
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: mess.getColor,
                                maxRadius: 25,
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
                              const SizedBox(width: 10),
                              SizedBox(
                                width: width * 0.8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          mess.getName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 5, 0),
                                          child: Text(
                                            "${months[mess.getMonth]} ${mess.getDay}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              mess.getSubject,
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
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.star_border_outlined)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ))),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget getDrawer(BuildContext context, double height, double width) {
    return Drawer(
        child: ListView(
      children: [
        Container(
          height: height * 0.13,
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.black),
          )),
          child: const DrawerHeader(
              child: Text(
            "Gmail",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          )),
        ),
        ListTile(
          leading: const Icon(Icons.inbox),
          trailing: const Text(
            "99+",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 14,
            ),
          ),
          title: const Text("Primary"),
          onTap: () {
            widget.searchController.clear();
            setState(() {
              currBox = CurrentBox.inbox.index;
              searches.clear();
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.local_offer_outlined),
          trailing: const Text(
            "2 new",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          title: const Text("Promotions"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.people_alt_outlined),
          trailing: const Text(
            "3 new",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 14,
            ),
          ),
          title: const Text("Social"),
          onTap: () {},
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(5, 4, 0, 4),
          child: Text(
            "All labels",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 14,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.star_border_outlined),
          title: const Text(
            "Starred",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.schedule),
          title: const Text(
            "Snoozed",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.label_important_outline),
          title: const Text(
            "Important",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.schedule_send_outlined),
          title: const Text(
            "Scheduled",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.outbox),
          title: const Text(
            "OutBox",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.description_outlined),
          title: const Text(
            "Draft",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.mail),
          title: const Text(
            "All mail",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          onTap: () {
            widget.searchController.clear();
            setState(() {
              currBox = CurrentBox.inbox.index;
              searches.clear();
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.error_outline),
          title: const Text(
            "Spam",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.send),
          title: const Text(
            "Sent",
            style: TextStyle(
              fontSize: 14,
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
              fontSize: 14,
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
          leading: const Icon(Icons.delete_outline),
          title: const Text(
            "Trash",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text(
            "Settings",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Settings(
                          email: widget._email,
                        )));
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
