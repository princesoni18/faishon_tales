import 'package:fashion_tales/utils/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySearchList extends StatelessWidget {
final List items=["tops","bottoms","jwellery","shoes","sweatpants","jeans"];
   MySearchList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      
      itemBuilder: 
      (context, index) {
        

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 10),
          child: CustomButton(title: items[index], size: 15,),
        );
      },);
  }
}