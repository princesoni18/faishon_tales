import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{

   final String email;
  final String profile;
  final String Username;
  
  final String uid;
  final List followers;
  final List following;

  UserModel({required this.email, required this.profile, required this.Username,  required this.uid, required this.followers, required this.following});



Map<String,dynamic> toJson()=>{

  'email':email,
  "Username":Username,
  'uid':uid,
  
  'profile':profile,
  'followers':followers,
  'following':following,
};
factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        Username:json["Username"],
        uid:json["uid"],
        profile:json["profile"],

        followers: List<String>.from(json["followers"].map((x) => x)),
        following: List<String>.from(json["following"].map((x) => x)),
    );
 static UserModel fromSnap(DocumentSnapshot snap){
  var snapshot= snap.data() as Map<String,dynamic>;

  return UserModel(
    Username: snapshot['Username'],
    uid: snapshot['uid'],
    
    profile: snapshot['profile'],
    followers: snapshot['followers'],
    following: snapshot['following'],
    email: snapshot['email']

  );
 }


}