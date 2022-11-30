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

  @override
  Widget build(BuildContext context){

    final overlays = Overlays(context);

    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if(_isAttachmentOpen){
            overlays.showAttachment(false);
            _isAttachmentOpen = false;
          }

          if(_isOptionsOpen){
            overlays.showOptions(false);
            _isOptionsOpen = false;
          }
        },
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
        ),
      ),
    );
  }

}