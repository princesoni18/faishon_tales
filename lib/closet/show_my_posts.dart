import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';


class ShowMyPosts extends StatelessWidget {
  final String uid;
  final String type;
  const ShowMyPosts({super.key,required this.uid ,required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     appBar: AppBar(
      title: Text(type),
     ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
        
          children: [
            
            FutureBuilder(
              future: FirebaseFirestore.instance
                    .collection('posts')
                    .where('uid',
                        isEqualTo: uid ).where('type',isEqualTo: type)
                    .get(),
        
                    builder: (context, snapshot) {
        
                      if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator());
                      }
        
        
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,), itemBuilder: (context, index) {
                        
                        // print((snapshot.data! as dynamic).docs[index]
                        //             ['profile'] );
                        return Container(
                          height: 200,
                          width: 200,
        
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage((snapshot.data! as dynamic).docs[index]
                                    ['postUrl']) ,fit: BoxFit.cover)
                          )
                        );
                      },);
                      
                    },
               )
          ],
          
        ),
      ),
    );
  }
}