import 'package:flutter/material.dart';
import 'message.dart';
import 'overlays.dart';

class ComposePage extends StatefulWidget{

  @override
  State<ComposePage> createState() => _ComposePageState();
}

class _ComposePageState extends State<ComposePage> {

  var _isAttachmentOpen = false;
  var _isOptionsOpen = false;

  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _subjectController = TextEditingController();
  final _composeEmailController = TextEditingController();

  @override
  Widget build(BuildContext context){

    final overlays = Overlays(context);

    void displayOverlays(){
      if(_isAttachmentOpen){
        overlays.showAttachment(false);
        _isAttachmentOpen = false;
      }

      if(_isOptionsOpen){
        overlays.showOptions(false);
        _isOptionsOpen = false;
      }
    }

    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => displayOverlays(),
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
                  onPressed: () {
                    overlays.showAttachment(true);
                    _isAttachmentOpen = true;
                  },
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
                onPressed: () {
                  overlays.showOptions(true);
                  _isOptionsOpen = true;
                },
                icon: Icon(
                  Icons.more_vert,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              TextField(
                controller: _fromController,
                decoration: InputDecoration(
                  label: Text(
                    "from",
                  )
                ),
                onTap: displayOverlays,
                readOnly: true,
              ),
              TextFormField(
                controller: _toController,
                autofocus: true,
                decoration: InputDecoration(
                    label: Text(
                      "to",
                    )
                ),
                onTap: displayOverlays,
              ),
              TextField(
                controller: _subjectController,
                decoration: InputDecoration(
                  hintText: "Subject"
                ),
                onTap: displayOverlays,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: _composeEmailController,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    hintText: "Compose email",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                  onTap: displayOverlays,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}