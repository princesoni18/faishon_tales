import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final String hinttext;
  final Icon? icon;
  final TextEditingController controller;
  final FocusNode? MyfocusNode;
  
  const MyTextField({super.key,required this.hinttext,required this.controller,this.icon,this.MyfocusNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
    focusNode: MyfocusNode,
      
      controller: controller,
      style: TextStyle(color: Colors.black ),
      decoration:  InputDecoration(
       
        iconColor: Theme.of(context).colorScheme.inversePrimary,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        prefixIcon: icon,
        prefixIconColor: Theme.of(context).colorScheme.inversePrimary,
hintText: hinttext,
fillColor: Theme.of(context).colorScheme.inversePrimary,
        focusedBorder:   OutlineInputBorder(
          
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary

          )
        ),
        enabledBorder:   OutlineInputBorder(
          
          borderSide: BorderSide(
            color: Colors.grey

          )
        ),

       

      ),
    );
  }
}