/*
For outputting message 
*/

import 'dart:ui';

class Message {
  Message(
      {required this.message,
      required this.sender,
      required this.name,
      this.subject = "None",
      required this.color,
      required this.dateReceived});
  String message;
  String sender;
  String name;
  String subject;
  Color color;
  DateTime dateReceived;

/* Getters */
  String get getMessage => message;
  String get getSender => sender;
  String get getName => name;
  String get getSubject => subject;
  Color get getColor => color;
  DateTime get getDate => dateReceived;
  int get getDay => dateReceived.day;
  int get getMonth => dateReceived.month;
  int get getYear => dateReceived.year;
}
