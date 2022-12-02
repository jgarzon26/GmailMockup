import 'dart:developer';

import 'package:flutter/material.dart';

class Overlays{

  late final BuildContext _context;

  OverlayEntry? _attachmentEntry;
  OverlayEntry? _optionsEntry;

  Overlays(this._context);

  void showAttachment(bool displayOverlay){
    final overlay = Overlay.of(_context)!;

    if(displayOverlay){
      _attachmentEntry = OverlayEntry(builder: (context) =>
          Positioned(
            width: MediaQuery.of(context).size.width * 0.8,
            left: MediaQuery.of(context).size.width * 0.5,
            top: MediaQuery.of(context).size.height * 0.08,
            child: _buildAttachment(),
          ));

      overlay.insert(_attachmentEntry!);
    } else{
      _attachmentEntry?.remove();
      _attachmentEntry = null;
    }
  }

  Widget _buildAttachment() => Material(
    child: Column(
      children: [
        ListTile(
          title: Text("Attach file"),
          onTap: () {},
        ),
        ListTile(
          title: Text("Insert from Drive"),
          onTap: () {},
        ),
      ],
    ),
  );

  void showOptions(bool displayOptions){
    final overlay = Overlay.of(_context)!;

    if(displayOptions){
      _optionsEntry = OverlayEntry(builder: (context) =>
          Positioned(
            width: MediaQuery.of(context).size.width * 0.8,
            left: MediaQuery.of(context).size.width * 0.5,
            top: MediaQuery.of(context).size.height * 0.08,
            child: _buildOptions(),
          ));

      overlay.insert(_optionsEntry!);
    }else{
      _optionsEntry?.remove();
      _optionsEntry = null;
    }
  }

  Widget _buildOptions() => Material(
    child: Column(
      children: [
        ListTile(
          title: Text("Schedule send"),
          onTap: () {},
        ),
        ListTile(
          title: Text("Add from Contacts"),
          onTap: () {},
        ),
        ListTile(
          title: Text("Confidential Mode"),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            "Save draft",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          onTap: null,
        ),
        ListTile(
          title: Text("Discard"),
          onTap: () {},
        ),
        ListTile(
          title: Text("Settings"),
          onTap: () {},
        ),
        ListTile(
          title: Text("Help and feedback"),
          onTap: () {},
        ),
      ],
    ),
  );
}