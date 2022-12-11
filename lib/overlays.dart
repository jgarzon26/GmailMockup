import 'dart:developer';

import 'package:flutter/material.dart';

class Overlays{

  late final BuildContext _context;

  OverlayEntry? _attachmentEntry;
  OverlayEntry? _optionsEntry;
  OverlayEntry? _accountEntry;
  OverlayEntry? _messageEntry;

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
    child: Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ]
      ),
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
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ]
      ),
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
    ),
  );

  void showAccountDetails(bool displayAccount, String email){
    final overlay = Overlay.of(_context)!;

    if(displayAccount){
      _accountEntry = OverlayEntry(builder: (context) =>
          Stack(
            children: [
              Container(
                color: Colors.black.withOpacity(0.8),
                child: GestureDetector(
                  onTap: () => _hideOverlay(_accountEntry),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width * 0.8,
                top: MediaQuery.of(context).size.height * 0.17,
                left: MediaQuery.of(context).size.width * 0.1,
                child: _buildAccount(email),
              ),
            ],
          ),
      );
      overlay.insert(_accountEntry!);
    } else {
      _hideOverlay(_accountEntry);
    }
  }

  Widget _buildAccount(String email) => Material(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.clear,
                  ),
                  onPressed: () {
                  _hideOverlay(_accountEntry);
                  },
                ),
              ),
              const Text(
                "Google",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(
              Icons.person,
          ),
          title: Text(
            email
          ),
          trailing: const Text(
            "99+",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ElevatedButton(
              onPressed: () {},
              child: const Text("Manage your Google Account"),
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.person_add_alt,
          ),
          title: const Text(
            "Add another account",
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.manage_accounts,
          ),
          title: const Text(
            "Manage accounts on this device",
          ),
          onTap: () {},
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  child: const Text("Privacy Policy")
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text("Terms of service")
              ),
            ],
          ),
        )
      ],
    ),
  );

  
  void showMessageOptions(bool displayOptions){
    final overlay = Overlay.of(_context)!;

    if(displayOptions){
      _messageEntry = OverlayEntry(builder: (context) =>
          Positioned(
            width: MediaQuery.of(context).size.width * 0.8,
            left: MediaQuery.of(context).size.width * 0.5,
            top: MediaQuery.of(context).size.height * 0.08,
            child: _buildMessageOptions(),
          ));

      overlay.insert(_messageEntry!);
    }else{
      _hideOverlay(_messageEntry);
    }
  }

  Widget _buildMessageOptions() => Material(
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ]
      ),
      child: Column(
        children: [
          ListTile(
            title: const Text("Move to"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Snooze"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Change labels"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Mark not important"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Mute"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Print"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Report spam"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Add to Tasks"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Help & feedback"),
            onTap: () {},
          ),
        ],
      ),
    ),
  );
}