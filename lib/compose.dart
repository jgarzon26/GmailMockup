import 'package:flutter/material.dart';
import 'message.dart';
import 'overlays.dart';

class ComposePage extends StatefulWidget{

  final String email;
  final void Function(Message) updateSentBox;

  const ComposePage(this.email, this.updateSentBox, {super.key});

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
  void initState(){
    super.initState();

    _fromController.text = widget.email;
  }

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
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
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
                onPressed: () {
                  var message = Message(message: _composeEmailController.text, sender: _toController.text, name: _fromController.text, color: Colors.blue, dateReceived: DateTime.now(), subject: _subjectController.text);
                  widget.updateSentBox(message);
                  Navigator.pop(context);
                },
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
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: _composeEmailController,
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      hintText: "Compose email",
                    ),
                    expands: true,
                    maxLines: null,
                    onTap: displayOverlays,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}