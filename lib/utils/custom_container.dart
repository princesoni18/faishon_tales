import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomContainer extends StatelessWidget {
  final double height;
  final String type;
  final String assetimagelink;
  const CustomContainer({super.key,required this.height,required this.type,required this.assetimagelink});

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
         color: Colors.grey[100],
        
     
         
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300,offset: Offset(0, 3),
            blurRadius: 7,spreadRadius: 2)
          ]
        
        ),
         margin: EdgeInsets.symmetric(horizontal: 16,vertical: 5),
      child: Container(
       height: height,
      
       
        decoration: BoxDecoration(
        
          borderRadius: BorderRadius.circular(7)
        ),
        child: Column(
         
          children: [
      
      
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(type,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(image: AssetImage("images/${assetimagelink}"),fit: BoxFit.cover)
                ),
              ),
            )
      
      
      
       
          ],
        ),
      
      ),
    );
  }
}