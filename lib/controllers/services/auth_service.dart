import 'dart:typed_data';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_tales/controllers/services/storage_methods.dart';
import 'package:fashion_tales/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService{

 final  FirebaseAuth _auth= FirebaseAuth.instance;
final FirebaseFirestore _firestore=FirebaseFirestore.instance;

Future<String> LogInUser(String email,String password)async{
String result="fill all fields";
  try{
  if(email.isNotEmpty&&password.isNotEmpty){
    // ignore: unused_local_variable
    UserCredential response= await _auth.signInWithEmailAndPassword(email: email, password: password);
    result="success";
  }
  else{
    result="enter all fields";
  }
   
   return result;
  }
  
  catch(e){

    return e.toString();
  }


}

Future<String> CreateUser(String email,String name,String password, Uint8List file)async{
String result="nottt";

  try{

    
   // ignore: unnecessary_null_comparison
   if(email.isNotEmpty||password.isNotEmpty||name.isNotEmpty||file!=null){
    UserCredential cred=await _auth.createUserWithEmailAndPassword(email: email, password: password);
    
     String url=await Storagemethods().uploadImageToStorage("ProfilePics", file, false);
     
   UserModel usermodel=UserModel(email: email, profile: url, Username: name, uid: cred.user!.uid, followers: [], following: []);
     await _firestore.collection('users').doc(cred.user!.uid).set(usermodel.toJson());

     result="success";
   }
   else{
    result="enter all fields";
   }
     return result;

  }
  catch(e){

    return e.toString();
  }

}
Future<void> logOutUser()async{

  try{
  await _auth.signOut();

  }catch(e){

    print(e.toString());
  }


}
Future<UserModel> getUserDetails() async{
  User currentUser=_auth.currentUser!;

  DocumentSnapshot snap=await _firestore.collection('users').doc(currentUser.uid).get();
   print("daaaata is fetchhhedd");
 return UserModel.fromSnap(snap);

}
}