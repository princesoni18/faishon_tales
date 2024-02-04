import 'dart:typed_data';

import 'package:fashion_tales/closet/post_type.dart';
import 'package:fashion_tales/controllers/services/firestore_methods.dart';
import 'package:fashion_tales/models/user_model.dart';
import 'package:fashion_tales/provider/user_provider.dart';
import 'package:fashion_tales/utils/custom_button.dart';
import 'package:fashion_tales/utils/image_picker.dart';
import 'package:fashion_tales/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

class MyPost extends StatefulWidget {
  const MyPost({super.key});

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  List type=["tops","bottoms","jwellery","shoes","sweatpants","jeans"];
  Uint8List? _file;
  bool isLoading=false;
  void postImage(String username, String uid, String profileImage) async {
    setState(() {
      isLoading=true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _file!, textEditingController.text, uid, username, profileImage,type[index]);
          if(res=='success'){
            setState(() {
              isLoading=false;
            });
            showSnackbar("Postes", context);
            clearImage();
            
          }
          else{
            setState(() {
              isLoading=false;
            });
            showSnackbar(res, context);
          }
    } catch (e) {}
  }
  void clearImage(){
    setState(() {
      _file=null;
    });
  }

  final TextEditingController textEditingController = TextEditingController();
  _selectimage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Create a Post"),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Take a Photo"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Take from gallery"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("cancel"),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
int index=0;
changeIndex(int val){

  setState(() {
    index=val;
  });
}
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }

  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Scaffold(
          appBar: AppBar(title: Text("Post "),),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ListView(
              shrinkWrap: true,
                    children: [
                    ListTile(title: Text("tops"),trailing: Icon(index==0?Icons.check_box:Icons.check_box_outline_blank_rounded),onTap: () => changeIndex(0),),
                    ListTile(title: Text("Bottoms"),trailing: Icon(index==1?Icons.check_box:Icons.check_box_outline_blank_rounded),onTap: () => changeIndex(1),),
                    ListTile(title: Text("Jwellery"),trailing: Icon(index==2?Icons.check_box:Icons.check_box_outline_blank_rounded),onTap: () => changeIndex(2),),
                    ListTile(title: Text("Shoes"),trailing: Icon(index==3?Icons.check_box:Icons.check_box_outline_blank_rounded),onTap: () => changeIndex(3),),
                    ListTile(title: Text("sweatpants"),trailing: Icon(index==4?Icons.check_box:Icons.check_box_outline_blank_rounded),onTap: () => changeIndex(4),),
                    ListTile(title: Text("jeans"),trailing: Icon(index==5?Icons.check_box:Icons.check_box_outline_blank_rounded),onTap: () => changeIndex(5),),
              
                    ],),
                    const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () => _selectimage(context),
                    child: CustomButton(title: "Upload", size: 16))
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
             
              leading:
                  IconButton(onPressed:clearImage, icon: Icon(Icons.arrow_back)),
              title: Text(type[index]),
              centerTitle: false,
              actions: [
                TextButton(
                    onPressed: () =>
                        postImage(user.Username, user.uid, user.profile),
                    child: const Text(
                      'Post',
                      style: TextStyle(
                          
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ))
              ],
            ),
            body: Column(
              children: [
                isLoading?const LinearProgressIndicator(
                  
                ):Container(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.profile),
                      radius: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: TextField(
                        controller: textEditingController,
                        decoration: const InputDecoration(
                            hintText: "Write a caption...",
                            border: InputBorder.none),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: MemoryImage(_file!),
                                  fit: BoxFit.fill,
                                  alignment: FractionalOffset.topCenter)),
                        ),
                      ),
                    ),
                    const Divider()
                  ],
                ),
                
              ],
            ),
          );
  }
}
