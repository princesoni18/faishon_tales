
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_tales/models/group_model.dart';
import 'package:fashion_tales/models/message_model.dart';
import 'package:fashion_tales/models/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class ChatService{


final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore =FirebaseFirestore.instance;

  Stream<List<UserModel>> getUserStream(){

    return _firestore.collection('users').snapshots().map((snapshot){

      return snapshot.docs.map((doc){
       
       // print(doc.data());
        final UserModel user=UserModel.fromJson(doc.data());

       

        return user;
      }).toList();
    });


  }

Future<void > createGroup(List<String> uids,String groupName,String groupPic)async{

  try{
    final _auth=FirebaseAuth.instance.currentUser!;

var groupId=Uuid().v1();
uids.add(_auth.uid);
Group group=Group(senderId: FirebaseAuth.instance.currentUser!.uid, name: groupName, groupId: groupId, lastMessage: "", groupPic: groupPic, membersUid: uids, timestamp: Timestamp.now(), );
await _firestore.collection('groups').doc(groupId).set(group.toMap());
  }
  catch(e){


    print(e.toString());
  }


}
 
  Future<void> sendMessage(String receiverID,String message )async{

    String currentUserId=_auth.currentUser!.uid;
    String currentUserEmail=_auth.currentUser!.email!;

    final Timestamp time=Timestamp.now();

    final mes=Message(message: message,
    senderEmail: currentUserEmail,
    senderID: currentUserId,
    receiverID: receiverID,
    timestamp: time);

    List<String> ids=[currentUserId,receiverID];

    ids.sort();

    String chatRoomId=ids.join('_'); 

    await _firestore.collection('chatRooms').doc(chatRoomId).collection("messages").add(mes.toJson());

  }
  Future<void> sendGroupMessage(String groupId,String message )async{

    String currentUserId=_auth.currentUser!.uid;
    String currentUserEmail=_auth.currentUser!.email!;

    final Timestamp time=Timestamp.now();

    final mes=Message(message: message,
    senderEmail: currentUserEmail,
    senderID: currentUserId,
    receiverID: groupId,
    timestamp: time);

    

    await _firestore.collection('groups').doc(groupId).collection("messages").add(mes.toJson());

  }

  Stream<QuerySnapshot> getMessages(String senderID,String receiverID){
   

    List<String> ids=[senderID,receiverID];

    ids.sort();

    String chatRoomId=ids.join('_');
  
    

    return  _firestore.collection('chatRooms').doc(chatRoomId).collection('messages').orderBy('timestamp',descending: false).snapshots();


  }
   Stream<QuerySnapshot> getGroupMessages(String groupId){
   

    

   
  
    

    return  _firestore.collection('groups').doc(groupId).collection('messages').orderBy('timestamp',descending: false).snapshots();


  }

}