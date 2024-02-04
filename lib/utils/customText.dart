import 'package:flutter/cupertino.dart';

class MyCustom extends StatelessWidget {
  final String first;
  final String second;
  const MyCustom({super.key,required this.first,required this.second});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [Text(first,style: TextStyle(fontSize: 16),),Text(second,style: TextStyle(fontSize: 12),)],
    );
  }
}