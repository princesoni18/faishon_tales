import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double? size;
  final Color? color;
   CustomButton({super.key,required this.title,required this.size,this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color??Colors.grey[200],
        borderRadius: BorderRadius.circular(7),

      ),
     child: Center(child: Text(title,style: TextStyle(fontSize: size),),),

    );
  }
}