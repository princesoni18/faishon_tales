import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_tales/groups/create_group.dart';
import 'package:fashion_tales/groups/group_screen.dart';
import 'package:fashion_tales/models/group_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyGroup extends StatelessWidget {
  const MyGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Groups"),
      foregroundColor: Colors.black,
      centerTitle: true,
      ),
      body: Column(
        children: [

          StreamBuilder(stream: FirebaseFirestore.instance.collection('groups').snapshots(),
          
           builder: (context,  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
          
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
          
             return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                List<String> memuid=[];
                for(int i=0;i<snapshot.data!.docs[index]['membersUid'].length;i++){

                   memuid.add(snapshot.data!.docs[index]['membersUid'][i].toString());
                }
               
              Group group=Group(senderId: snapshot.data!.docs[index]['senderId'], name: snapshot.data!.docs[index]['name'], groupId: snapshot.data!.docs[index]['groupId'], lastMessage: snapshot.data!.docs[index]['lastMessage'], groupPic: snapshot.data!.docs[index]['groupPic'], membersUid: memuid, timestamp: snapshot.data!.docs[index]['timeSent']);
             
           //print(group.name);
                return GestureDetector(
     onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => GroupChatPage(group:group, senderID: FirebaseAuth.instance.currentUser!.uid, ),)),
      child: Container(
       decoration: BoxDecoration(
        color: const Color.fromARGB(255, 246, 202, 217),
    
        borderRadius: BorderRadius.circular(8)
       ),
        margin: EdgeInsets.symmetric(horizontal: 14,vertical: 10),
       height: 80,
       width: double.infinity,
    
        child: Row(
          children: [
            
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 8),
             child: CircleAvatar(
              
              radius: 50,
           
              backgroundImage: NetworkImage(snapshot.data!.docs[index]['groupPic'],),
             ),
           ),
    
           Expanded(
             child: FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              child: Text(snapshot.data!.docs[index]['name'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),)),
           )
          ],
        ),
      ),
    );
                  
                 
               
              
             },);
           },),
        ],
      ),
       floatingActionButton: FloatingActionButton(onPressed:()=> Navigator.push(context, MaterialPageRoute(builder: (context) => CreateGroupScreen(),)),child: Icon(Icons.add,),backgroundColor: Colors.pink[200],),
    );
  }
}