import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  const MyAppBar({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
    child: Text(title),
    );
  }
}