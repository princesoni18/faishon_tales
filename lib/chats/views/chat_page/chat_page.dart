



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_tales/components/MyTextField.dart';
import 'package:fashion_tales/components/chat_box.dart';
import 'package:fashion_tales/controllers/services/chat_service.dart';
import 'package:fashion_tales/models/message_model.dart';
import 'package:fashion_tales/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {
  final receiverID;
  final senderID;
  final UserModel user;
  ChatPage({super.key, required this.receiverID, required this.senderID,required this.user});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseAuth _auth=FirebaseAuth.instance;

  final FocusNode MyfocusNode=FocusNode();
  final TextEditingController _messageController = TextEditingController();

   final ScrollController _scrollcontroller=ScrollController();
void scrollDown(){
    
   
    _scrollcontroller.animateTo(_scrollcontroller.position.maxScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.fastEaseInToSlowEaseOut);


   }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    MyfocusNode.addListener((){

    if(MyfocusNode.hasFocus){
      Future.delayed(Duration(milliseconds: 500),()=> scrollDown());
      
    }
  }
    
  );
  Future.delayed(Duration(milliseconds: 500),()=> scrollDown());
    
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    MyfocusNode.dispose();
    _messageController.dispose();
  }

   

  @override
  Widget build(BuildContext context) {

    
    return  Scaffold(
    backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
    leadingWidth: 30,
      elevation:0.0,
      
           title: Row(
            
            children: [
   Padding(

              padding: const EdgeInsets.only(top: 5),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(widget.user.profile),
              ),
            ),
            
           const SizedBox(width: 10,),
               Expanded(
                
                
                   child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(widget.user.Username,overflow: TextOverflow.ellipsis,)),
                 ),
               
            

            ],
           ),
          // leading: 
         
        
        ),
      ),
        body: Column(
          children: [
            Expanded(
                child:
                    Message_List(context)),
           _sendMessage(widget.receiverID),
          ],
        ),
      
    );
  }

  Widget Message_List(BuildContext context) {
     
   
   
   
    return StreamBuilder(
      stream: ChatService().getMessages(widget.senderID, widget.receiverID),
      
      builder: (context, snapshot) {
     
        if (snapshot.hasError) {
          return Center(
            child: Text("some error occured"),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child:Text("Loading..."),
          );
        }

        return ListView(
          controller: _scrollcontroller,
          children: snapshot.data!.docs.map((doc) => _listItems(doc)).toList(),
        );

        
      },
    );
  }

  Widget _listItems(DocumentSnapshot snap) {


  final Message msg = Message.fromJson(snap.data() as Map<String, dynamic>);
  
  bool align=_auth.currentUser!.uid==msg.senderID?true:false;
   
  return Container(
   margin: EdgeInsets.all(8),
   alignment: align?Alignment.centerRight:Alignment.centerLeft,
    
    
    child:ChatBubble(IscurrentUser: align, text: msg.message)
  );
}

Widget _sendMessage(String receiverID) {
  
  
  
  void _sendText(String receiverID)async{


  if(_messageController.text.isEmpty){
    return;
  }
  else{
   await ChatService().sendMessage(receiverID, _messageController.text);
   
   _messageController.clear();
   scrollDown();

  }
}


  return Padding(
    padding: const EdgeInsets.all(14.0),
    child: Row(
      children: [
        Expanded(
          
            child: MyTextField(
              
             hinttext: "Type Your Message",
              controller: _messageController,
              MyfocusNode: MyfocusNode,
            ),
          
        ),
        GestureDetector(
          onTap: () =>_sendText(receiverID),
          
          child: Container(
            height: 50,
            width: 50,
           margin: EdgeInsets.only(left: 10), 
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle
            ),
            
            
            child: Icon(Icons.arrow_upward_rounded,size: 35,color: Colors.grey[100],)))
      ],
    ),
  );



}
}