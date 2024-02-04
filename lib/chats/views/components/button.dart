import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
   final void Function()? ontap;
   MyButton({super.key,required this.text,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:ontap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
    
    
          color: Colors.green[400],
    
          borderRadius: BorderRadius.circular(10)
        ),
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
        child: Center(child: Text(text)),
      ),
    );
  }
}