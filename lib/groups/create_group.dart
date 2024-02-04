
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_tales/controllers/services/chat_service.dart';
import 'package:fashion_tales/controllers/services/storage_methods.dart';
import 'package:fashion_tales/models/user_model.dart';
import 'package:fashion_tales/utils/image_picker.dart';
import 'package:fashion_tales/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class CreateGroupScreen extends StatefulWidget {
  static const String routeName = '/create-group';
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final List<String> uids=[];
  final TextEditingController groupNameController = TextEditingController();
  Uint8List? image;

  void selectImage() async {
    image = await pickImage(ImageSource.gallery);
    setState(() {});
  }
  void selectcontact(String uid){
    if(uids.contains(uid)){
      uids.remove(uid);
    }
    else uids.add(uid);

    setState(() {
      
    });

  }
  void createGroup() async{
    if (groupNameController.text.trim().isNotEmpty && image != null) {
    String url =await  Storagemethods().uploadImageToStorage("groupProfile",image!,false);


      ChatService().createGroup(uids, groupNameController.text, url);
      Navigator.pop(context);
    }
    else showSnackbar("please fill all fields", context);
  }

  @override
  void dispose() {
    super.dispose();
    groupNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _auth=FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Stack(
              children: [
                image == null
                    ? const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
                        ),
                        radius: 64,
                      )
                    : CircleAvatar(
                        backgroundImage: MemoryImage(
                          image!,
                        ),
                        radius: 64,
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: groupNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Group Name',
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Select People',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FutureBuilder(future:FirebaseFirestore.instance.collection('users').get() 
            
            , builder: (context, snapshot) {

               if(!snapshot.hasData){

                return CircularProgressIndicator();
               }

               return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  UserModel user=UserModel.fromSnap(snapshot.data!.docs[index]);
                // print(user.followers);
                // print(_auth.uid);
                   if(user.followers.contains(_auth.uid)==true){

                    return ListTile(
                      leading: IconButton(onPressed: ()=>selectcontact(user.uid), icon: Icon(uids.contains(user.uid)?Icons.check_box:Icons.check_box_outline_blank_rounded)),
                      title:Text(user.Username) ,
                    );
                  }
                  else return Container();
                },);
              
              
            },),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createGroup,
        backgroundColor: Colors.pink[200],
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
    );
  }
}