import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool IscurrentUser;
  const ChatBubble({super.key,required this.IscurrentUser,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
   padding:const  EdgeInsets.all(10),
 decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(15),

  color: IscurrentUser?Colors.pink[200]:Colors.grey[300]
 ),
      child: Text(text,style: const TextStyle(fontSize: 16),),
    );
  }
}