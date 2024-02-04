import 'package:cloud_firestore/cloud_firestore.dart';

class Message{

  final String senderID;
  final String receiverID;
  final String message;
  final String senderEmail;
  final Timestamp timestamp;

  Message({required this.senderID, required this.receiverID, required this.message, required this.senderEmail, required this.timestamp});


factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderID: json['senderID'] as String,
      receiverID: json['receiverID'] as String,
      message: json['message'] as String,
      senderEmail: json['senderEmail'] as String,
      timestamp: json['timestamp'] ,
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'senderID': senderID,
      'receiverID': receiverID,
      'message': message,
      'senderEmail': senderEmail,
      'timestamp': timestamp,
    };
  }
}