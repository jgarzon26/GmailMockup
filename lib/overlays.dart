import 'dart:developer';

import 'package:flutter/material.dart';

class Overlays{

  late final BuildContext _context;

  OverlayEntry? _attachmentEntry;
  OverlayEntry? _optionsEntry;
  OverlayEntry? _accountEntry;

  Overlays(this._context);

  void _hideOverlay(OverlayEntry? entry){
    entry?.remove();
    entry = null;
  }

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
      _hideOverlay(_attachmentEntry);
    }
  }

  Widget _buildAttachment() => Material(
    child: Column(
      children: [
        ListTile(
          title: const Text("Attach file"),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Insert from Drive"),
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
      _hideOverlay(_optionsEntry);
    }
  }

  Widget _buildOptions() => Material(
    child: Column(
      children: [
        ListTile(
          title: const Text("Schedule send"),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Add from Contacts"),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Confidential Mode"),
          onTap: () {},
        ),
        const ListTile(
          title: Text(
            "Save draft",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          onTap: null,
        ),
        ListTile(
          title: const Text("Discard"),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Settings"),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Help and feedback"),
          onTap: () {},
        ),
      ],
    ),
  );

  void showAccountDetails(bool displayAccount, String email){
    final overlay = Overlay.of(_context)!;

    if(displayAccount){
      _accountEntry = OverlayEntry(builder: (context) =>
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: _buildAccount(email),
            ),
          ),
        opaque: true,
      );

      overlay.insert(_accountEntry!);
    } else {
      _hideOverlay(_accountEntry);
    }
  }

  Widget _buildAccount(String email) => Material(
    child: Column(
      children: [
        ListTile(
          leading: IconButton(
            icon: Icon(
              Icons.clear,
            ),
            onPressed: () {
              _hideOverlay(_accountEntry);
            },
          ),
          title: Text(
            "Google",
            textAlign: TextAlign.center,
          ),
        ),
        ListTile(
          leading: Icon(
              Icons.person,
          ),
          title: Text(
            email
          ),
          trailing: Text(
            "99+",
          ),
        ),
        ElevatedButton(
            onPressed: () {},
            child: Text("Manage your Google Account"),
        ),
        ListTile(
          leading: Icon(
            Icons.person_add_alt,
          ),
          title: Text(
            "Add another account",
          ),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            Icons.manage_accounts,
          ),
          title: Text(
            "Manage accounts on this device",
          ),
          onTap: () {},
        ),
        Row(
          children: [
            ElevatedButton(onPressed: () {}, child: Text("Privacy Policy")),
            ElevatedButton(onPressed: () {}, child: Text("Terms of service")),
          ],
        )
      ],
    ),
  );
}