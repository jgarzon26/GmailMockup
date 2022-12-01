import 'package:flutter/material.dart';

class GeneralSettings extends StatefulWidget {
  const GeneralSettings({super.key});

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  @override
  Widget build(BuildContext context) {
    bool checkConvoView = true;
    bool checkNav = true;
    bool checkAutoFit = true;
    bool checkDelete = false;
    bool checkArchive = false;
    bool checkSend = false;
    var size = MediaQuery.of(context).size;
    var width = size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text("General Settings"),
        ),
        body: ListView(
          children: <Widget>[
            InkWell(
                onTap: () {},
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: width,
                    height: 65,
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Theme",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "System Default",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ]))),
            InkWell(
                onTap: () {},
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: width,
                    height: 65,
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Default notification action",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Archive",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ]))),
            InkWell(
                onTap: () {},
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: width,
                    height: 50,
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black))),
                    child: const Text(
                      "Manage notifications",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ))),
            InkWell(
                onTap: () {
                  setState(() {
                    checkConvoView = !checkConvoView;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: width,
                  height: 90,
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Conversation view",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.8,
                                child: const Text(
                                  "Group emails in the same conversation together for IMAP, POP3, and Exchange accounts",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              )
                            ]),
                        IgnorePointer(
                          child: Checkbox(
                            value: checkConvoView,
                            onChanged: (_) {},
                          ),
                        )
                      ]),
                )),
            InkWell(
                onTap: () {},
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: width,
                    height: 65,
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Conversion list density",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Default",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ]))),
            InkWell(
                onTap: () {
                  setState(() {
                    checkNav = !checkNav;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: width,
                  height: 65,
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Hide bottom navigation on scroll",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        IgnorePointer(
                          child: Checkbox(
                            value: checkNav,
                            onChanged: (_) {},
                          ),
                        )
                      ]),
                )),
            InkWell(
                onTap: () {},
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: width,
                    height: 84,
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Swipe actions",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Configure swipe actions to quickly act on emails in the conversation list",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ]))),
            InkWell(
                onTap: () {},
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: width,
                    height: 65,
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Default reply action",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Choose your default reply action",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ]))),
            InkWell(
                onTap: () {
                  setState(() {
                    checkAutoFit = !checkAutoFit;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: width,
                  height: 65,
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Auto-fit messages",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Shrink messages to fit the screen",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ]),
                        IgnorePointer(
                          child: Checkbox(
                            value: checkConvoView,
                            onChanged: (_) {},
                          ),
                        )
                      ]),
                )),
            InkWell(
                onTap: () {},
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: width,
                    height: 65,
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Auto-advance",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Show conversation list after you archive or delete",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ]))),
            Container(
                padding: const EdgeInsets.all(8.0),
                width: width,
                height: 40,
                child: const Text(
                  "Action Confirmations",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                )),
            InkWell(
                onTap: () {
                  setState(() {
                    checkDelete = !checkDelete;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: width,
                  height: 50,
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Confirm before deleting",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        IgnorePointer(
                          child: Checkbox(
                            value: checkDelete,
                            onChanged: (_) {},
                          ),
                        )
                      ]),
                )),
            InkWell(
                onTap: () {
                  setState(() {
                    checkArchive = !checkArchive;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: width,
                  height: 50,
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Confirm before archiving",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        IgnorePointer(
                          child: Checkbox(
                            value: checkArchive,
                            onChanged: (_) {},
                          ),
                        )
                      ]),
                )),
            InkWell(
                onTap: () {
                  setState(() {
                    checkSend = !checkSend;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: width,
                  height: 50,
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Confirm before sending",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        IgnorePointer(
                          child: Checkbox(
                            value: checkSend,
                            onChanged: (_) {},
                          ),
                        )
                      ]),
                )),
          ],
        ));
  }
}
