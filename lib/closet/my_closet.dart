



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_tales/closet/add_new_post.dart';
import 'package:fashion_tales/closet/show_my_posts.dart';
import 'package:fashion_tales/controllers/services/firestore_methods.dart';

import 'package:fashion_tales/models/user_model.dart';
import 'package:fashion_tales/provider/user_provider.dart';

import 'package:fashion_tales/utils/appbar.dart';
import 'package:fashion_tales/utils/customText.dart';
import 'package:fashion_tales/utils/custom_button.dart';
import 'package:fashion_tales/utils/custom_container.dart';
import 'package:fashion_tales/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


import 'package:provider/provider.dart';


class MyCloset extends StatefulWidget {
  final String uid;
 
  const MyCloset({super.key ,required this.uid});

  @override
  State<MyCloset> createState() => _MyClosetState();
}

class _MyClosetState extends State<MyCloset> {
   var postscount=0;
  bool _isloading=true;
 int followers=0;
   late UserModel? user;
   bool isfollowing=false;
  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
    addData();
   

    
   

  }
followUser(String uid,String followId)async{
//print("follow button clicked");
  await FirestoreMethods().followUser(uid, followId);
  
  setState(() {

    isfollowing?followers--:followers++;
     isfollowing=!isfollowing;
     
  });
}
  addData()async{

    try{
      var snap=   await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();

      
      user=UserModel.fromSnap(snap);
      // print("uidddd");
      // print(FirebaseAuth.instance.currentUser!.uid);

      isfollowing=user!.followers.contains(FirebaseAuth.instance.currentUser!.uid);
    var posts=await FirebaseFirestore.instance.collection('posts').where('uid' ,isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    postscount=posts.docs.length;

    followers=user!.followers.length;

      setState(() {
        _isloading=false;
      });
    }
    catch(e){
      showSnackbar(e.toString(), context);
    }
  }
  List <double>heights=[300,250,250,300,300,250];
  final List items=["tops","bottoms","jwellery","shoes","sweatpants","jeans"];
  final List images=["tops.png","bottoms.jpg","jwellery.jpg","shoes.jpg","sweatpants.jpg","jeans.jpg"];
  @override
  Widget build(BuildContext context) {
    
   
    return Scaffold(
      
      
      appBar: AppBar(
        title: _isloading?Text("closet") :MyAppBar(title: "${user!.Username}'s Closet"),
        centerTitle: true,
      ),
      body: _isloading?Center(child: CircularProgressIndicator(),):  ListView(
            children: [
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [ Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            
          CircleAvatar(radius: 40,
          backgroundImage: NetworkImage(user!.profile),),
          const SizedBox(height: 7,),
          Container(child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(user!.Username,style: TextStyle(fontSize: 16),))),
          Container(child: FittedBox(
             fit: BoxFit.scaleDown,
            child: Text(user!.email,style: TextStyle(fontSize: 10),))),
          
        ],
      ),
       Expanded(child: Container()),
     
    Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyCustom(first: followers.toString(), second: "followers"),
        const SizedBox(width: 10,),
         MyCustom(first: user!.following.length.toString(), second: "following"),
         const SizedBox(width: 10,),
          MyCustom(first: postscount.toString(), second: "posts"),
          const SizedBox(width: 5,),
      ],
    ),
    
    
    
    
    const SizedBox(height: 15,),
              user!.uid==FirebaseAuth.instance.currentUser!.uid? Row(children: [CustomButton(title: "Edit profile",size: 12,),const SizedBox(width: 10,),  add_NewButton(),],) :
              GestureDetector(
                onTap: ()=>followUser(FirebaseAuth.instance.currentUser!.uid,user!.uid),
                child: Container(
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color:isfollowing?Colors.grey[200]:Colors.pink[300]
                  ),
                  width: 150,child: isfollowing?Text("Following") :Text("Follow"),),
              )
                 ],) ,
                 Expanded(child: Container()),
                 
     
      ],
    )
                ),
                const SizedBox(height: 15,),
                MasonryGridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context, index) {
                    return 
                   
                       GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ShowMyPosts(uid: user!.uid,type: items[index],),)),
                        child: CustomContainer(height:heights[index],type: items[index],assetimagelink: images[index],));
                  },)
        
        
        
          
            ],
          )
      
      
    );
  }
}


class add_NewButton extends StatefulWidget {
  const add_NewButton({
    super.key,
  });

  @override
  State<add_NewButton> createState() => _add_NewButtonState();
}

class _add_NewButtonState extends State<add_NewButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => MyPost(),)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.pink.shade200),
        child:const  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Icon(Icons.add_circle_outline),const SizedBox(width: 10,), Text("Add New")],
          ),
        
      ),
    );
  }



}