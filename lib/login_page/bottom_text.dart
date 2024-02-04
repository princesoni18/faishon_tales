

import 'package:fashion_tales/register_page/register_page.dart';
import 'package:flutter/material.dart';
class Bottom_Text extends StatelessWidget {
  final BuildContext context;
  const Bottom_Text({
    super.key,
    required this.context
  });

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:14.0),
      child:  
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
           SizedBox(width: MediaQuery.of(context).size.width*0.2,),
             Text("New to CHATZO ?",overflow: TextOverflow.ellipsis,style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
          
          
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register_Page(),)),
                  child: Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
              ),
             
          ],
        ),
      
    );
  }
}