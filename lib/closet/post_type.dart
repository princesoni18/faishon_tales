import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TypeOfPost extends StatefulWidget {
   TypeOfPost({super.key});

  @override
  State<TypeOfPost> createState() => _TypeOfPostState();
}

class _TypeOfPostState extends State<TypeOfPost> {
  int index=0;

changeIndex(int val){

  setState(() {
    index=val;
  });
}

  @override
  Widget build(BuildContext context) {
    return ListView(
shrinkWrap: true,
      children: [
      ListTile(title: Text("tops"),trailing: Icon(index==0?Icons.check_box:Icons.check_box_outline_blank_rounded),onTap: () => changeIndex(0),),
      ListTile(title: Text("Bottoms"),trailing: Icon(index==1?Icons.check_box:Icons.check_box_outline_blank_rounded),onTap: () => changeIndex(1),),
      ListTile(title: Text("Jwellery"),trailing: Icon(index==2?Icons.check_box:Icons.check_box_outline_blank_rounded),onTap: () => changeIndex(2),),
      ListTile(title: Text("Shoes"),trailing: Icon(index==3?Icons.check_box:Icons.check_box_outline_blank_rounded),onTap: () => changeIndex(3),),
      ListTile(title: Text("sweatpants"),trailing: Icon(index==4?Icons.check_box:Icons.check_box_outline_blank_rounded),onTap: () => changeIndex(4),),
      ListTile(title: Text("jeans"),trailing: Icon(index==5?Icons.check_box:Icons.check_box_outline_blank_rounded),onTap: () => changeIndex(5),),

      ],
    );
  }
}