import 'package:fashion_tales/home/home_page.dart';
import 'package:fashion_tales/provider/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyLayout extends StatefulWidget {
  const MyLayout({super.key});

  @override
  State<MyLayout> createState() => _MyLayoutState();
}

class _MyLayoutState extends State<MyLayout> {
  bool _isloading=true;
  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
     addData();
  }

  addData()async{
  UserProvider prov=Provider.of(context,listen: false);

  await prov.refreshUser();
  
  setState(() {
    _isloading=false;
  });

  }
  @override
  Widget build(BuildContext context) {
    return _isloading==true?Scaffold(body: Center(child: CircularProgressIndicator())):MyHome();
  }
}