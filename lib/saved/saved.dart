import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_tales/controllers/services/firestore_methods.dart';
import 'package:fashion_tales/post_card/post_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Saved extends StatefulWidget {

   Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  late List<dynamic> posts=[];
  bool _isloading=true;

  @override
  void initState() {
    super.initState();
    addList();
  }
 addList()async{


posts=await FirestoreMethods().createlist();


  _isloading=false;
  setState(() {
    
  });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text("S a v e d"),
  centerTitle: true,
),
      body:_isloading?const Center(child: Text("loading...."),):
      SingleChildScrollView(
        child: Column(
          children: [
            posts.length==0?Text("Sorry you not saved anything"):Container(),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return PostCard(snap: posts[index]);
            },),]
        ),
      )

      
      
      // FutureBuilder(
      //         future: FirebaseFirestore.instance
      //             .collection('saved').doc(FirebaseAuth.instance.currentUser!.uid).collection('mysaves').get(),
                  
      //         builder: (context, snapshot) {
      //           if (!snapshot.hasData) {
      //             return Center(
      //               child: CircularProgressIndicator(),
      //             );
      //           }
      //            List<dynamic> posts=await FirestoreMethods().createlist(snapshot);

      //           for(int i=0;i<snapshot.data!.docs.length;i++){
      //          Future<DocumentSnapshot<Map<String, dynamic>>>snap =FirebaseFirestore.instance.collection('posts').doc((snapshot.data! as dynamic).docs[i]['postId']).get();
      //         posts.add(snap);
      //            print(snap);



      //           }
      //          return ListView.builder(
      //           itemCount: posts.length,
      //           itemBuilder: (context, index) {
      //            return Text(posts[index]['postUrl']);
      //          },);
      //           // return ListView.builder(
                
      //           //     itemCount: snapshot.data!.docs.length,

      //           //     itemBuilder: (context, index) {
      //           //          return FutureBuilder(
      //           //           future: FirebaseFirestore.instance
      //           //   .collection('posts').doc((snapshot.data! as dynamic).docs[index]['postId']).get(), builder: (context, snap) {

      //           //     if (!snapshot.hasData) {
      //           //   return Center(
      //           //     child: CircularProgressIndicator(),
      //           //   );}
      //           //      return PostCard(snap:   (snap.data! as dynamic));
      //           //   },);
                    
                     
                     
      //           //     });
      //         })
    );
  }
}