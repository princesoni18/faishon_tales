
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_tales/controllers/services/storage_methods.dart';
import 'package:fashion_tales/models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(Uint8List file, String description, String uid,
      String username, String profileImage,String type) async {
    String res = "some error occured";
    try {
      String url =
          await Storagemethods().uploadImageToStorage("posts", file, true);
      String postId = const Uuid().v1();
      Postmodel post = Postmodel(
          description: description,
          postId: postId,
          Username: username,
          datePublished: DateTime.now().toString(),
          uid: uid,
          postUrl: url,
          profileImage: profileImage,
          likes: [],type: type,bookmarked: []);

      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = "error occured";
    }
    return res;
  }
  Future<void> likePost(String uid,String postId,List likes)async{
    try{
      if(likes.contains(uid)){
       await  _firestore.collection('posts').doc(postId).update({
          'likes':FieldValue.arrayRemove([uid]),
        });
      }
      else{
        await _firestore.collection('posts').doc(postId).update({
         'likes':FieldValue.arrayUnion([uid])

        });
      }

    } catch(e){
      print(e.toString());
    }

  }
  Future<void>postComment(String postId,String text,String uid,String name,String profileImage) async{
  try{
    if(text.isNotEmpty){
      String commentId=const Uuid().v1();
       await _firestore.collection('posts').doc(postId).collection("comments").doc(commentId).set(
        {
          "profileImage":profileImage,
          "Username":name,
          'uid':uid,
          'text':text,
          "commentId":commentId,
          "datePublished":DateTime.now(),

        }
      );
    }else{
      print("text is empty");
    }


  }catch (e){
   print(e.toString());
  }
  
  }

  //deleting the post
  Future<void> deletePost(String postId) async{
    try{
    _firestore.collection('posts').doc(postId).delete();
    } catch(e){
      print (e.toString());
    }

  }
  //save the post

  Future<void>savePost(String uid,String postId,List bookmarked)async{
   try{
      if(bookmarked.contains(uid)){
       await  _firestore.collection('posts').doc(postId).update({
          'bookmarked':FieldValue.arrayRemove([uid]),

       
        });
        await _firestore.collection('saved').doc(uid).collection('mysaves').doc(postId).delete();
      }
      else{
        await _firestore.collection('posts').doc(postId).update({
         'bookmarked':FieldValue.arrayUnion([uid])

        });
         await _firestore.collection('saved').doc(uid).collection('mysaves').doc(postId).set({'postId':postId});
      }

    } catch(e){
      print(e.toString());
    }

  }

  Future<List<dynamic>> createlist()async{

    try{
       final snap =await FirebaseFirestore.instance.collection('saved').doc(FirebaseAuth.instance.currentUser!.uid).collection('mysaves').get();

       final List<dynamic>posts=[];
       print("lenghjt");
      print((snap).docs.length);
       for(int i=0;i<(snap).docs.length;i++){
               DocumentSnapshot<Map<String, dynamic>>snapshot =await FirebaseFirestore.instance.collection('posts').doc(((snap as dynamic).docs[i]['postId'])).get();
              posts.add((snapshot));
                 print((snapshot as dynamic)['postUrl']);

                



                }
  
print(posts.length);
  return posts;
    }
    catch(e){

      print(e.toString());
      return [];
    }
  }

  Future<void> followUser(String uid,String followId)async{



    try{
    DocumentSnapshot snap= await _firestore.collection('users').doc(uid).get();

    List following=(snap.data()! as dynamic)['following'];

    if(following.contains(followId)){

   await _firestore.collection('users').doc(followId).update({'followers':FieldValue.arrayRemove([uid])});

   await _firestore.collection('users').doc(uid).update({'following':FieldValue.arrayRemove([followId])});
    }
    else{

      await _firestore.collection('users').doc(followId).update({'followers':FieldValue.arrayUnion([uid])});

   await _firestore.collection('users').doc(uid).update({'following':FieldValue.arrayUnion([followId])});

    }

    }

    catch(e){
      print(e.toString());
    }
  }
 }
