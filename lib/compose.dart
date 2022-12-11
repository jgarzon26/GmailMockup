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

  var overlays;

  var _isAttachmentOpen = false;
  var _isOptionsOpen = false;

  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _ccController = TextEditingController();
  final _bccController = TextEditingController();
  final _subjectController = TextEditingController();
  final _composeEmailController = TextEditingController();

  var _showMore = false;

  void _setShowMore(bool display){
    setState(() {
      _showMore = display;
    });
  }

  @override
  void initState(){
    super.initState();

    _fromController.text = widget.email;
  }

  void _displayOverlays(){
    if(_isAttachmentOpen){
      overlays.showAttachment(false);
      _isAttachmentOpen = false;
    }

    if(_isOptionsOpen){
      overlays.showOptions(false);
      _isOptionsOpen = false;
    }
  }

  @override
  Widget build(BuildContext context){

    overlays = Overlays(context);

    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _displayOverlays(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
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
                  prefix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "From",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  _displayOverlays();
                  _setShowMore(false);
                },
                readOnly: true,
                enabled: false,
              ),
              TextFormField(
                controller: _toController,
                autofocus: true,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.4),
                      )
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        "To",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                  suffixIcon: !_showMore ? IconButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      _setShowMore(true);
                    },
                  ) : null,
                ),
                onTap: () {
                  _displayOverlays();
                  _showMore = false;
                },
              ),
              dropDownDetails(),
              TextField(
                controller: _subjectController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.4),
                        )
                    ),
                  hintText: "Subject"
                ),
                onTap: () {
                  _displayOverlays();
                  _setShowMore(false);
                },
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: _composeEmailController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      isCollapsed: true,
                      hintText: "Compose email",
                    ),
                    expands: true,
                    maxLines: null,
                    onTap: () {
                      _displayOverlays();
                      _setShowMore(false);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropDownDetails()
  {
    return Column(
      children: [
        if(_showMore || _ccController.text.isNotEmpty)  TextFormField(
          autofocus: true,
          controller: _ccController,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.4),
                ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Cc",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          ),
          onTap: _displayOverlays,
        ),
        if(_showMore || _bccController.text.isNotEmpty)  TextFormField(
          autofocus: true,
          controller: _bccController,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.4),
                )
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Bcc",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          ),
          onTap: _displayOverlays,
        ),
      ],
    );
  }

}