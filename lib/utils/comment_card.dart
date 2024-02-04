import 'package:flutter/material.dart';

import 'package:intl/intl.dart';


class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key,required this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16,
      horizontal: 16),
      height: 80,
     child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

      CircleAvatar(
        backgroundImage: NetworkImage(widget.snap['profileImage']),
         radius: 18,),
         Expanded(
           child: Padding(padding: const EdgeInsets.only(left: 16,),
           
           child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(text: TextSpan(
                children: [TextSpan(
                  text: widget.snap['Username'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black
         
                  )
                ),
                TextSpan(
                  text:  "  ${DateFormat.yMMMd().format(widget.snap['datePublished'].toDate())}" ,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15
         
                  )
                ),
                
                ]
              )),
              Text(widget.snap['text'],style: TextStyle(color: Colors.black),)
            ],
           ) ,),
         ),

        
            IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outline,size: 18,)),

           
          
     ]),
    );
  }
}