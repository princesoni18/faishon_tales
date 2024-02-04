import 'package:fashion_tales/firebase_options.dart';

import 'package:fashion_tales/layout.dart';
import 'package:fashion_tales/login_page/login_page.dart';
import 'package:fashion_tales/provider/user_provider.dart';
import 'package:fashion_tales/register_page/register_page.dart';
import 'package:fashion_tales/theme.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [

     ChangeNotifierProvider(create: (_)=>UserProvider())
    ],
    
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faishon App',
      debugShowCheckedModeBanner: false,
     
      
      theme: ThemeData(
       
       
      textTheme: GoogleFonts.latoTextTheme(),
    
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
           if(!snapshot.hasData){
            return Register_Page();
           }
          if(snapshot.connectionState==ConnectionState.active){
             print("connection active");
            return MyLayout();
          }
          if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.connectionState==ConnectionState.none) {
            return Register_Page();
          }
          return Login_Page();
        }
      ),
    );
  }
}

