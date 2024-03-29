import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_tales/controllers/services/firestore_methods.dart';
import 'package:fashion_tales/models/user_model.dart';
import 'package:fashion_tales/provider/user_provider.dart';
import 'package:fashion_tales/utils/comment_card.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({super.key, required this.snap});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentcontroller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        
        title: const Text("Comments"),
        centerTitle: false,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.snap['postId'])
              .collection('comments')
              .orderBy('datePublished',descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                 
                ),
              );
            }
            return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) => CommentCard(
                snap:(snapshot.data! as dynamic).docs[index].data()
              ),
            );
          }),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.profile),
              radius: 18,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TextField(
                  style: TextStyle(color: Colors.black ),
                  controller: _commentcontroller,
                  decoration: InputDecoration(
                    
                      hintText: "Comment as ${user.Username}",
                      border: InputBorder.none,
                      ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await FirestoreMethods().postComment(
                    widget.snap['postId'],
                    _commentcontroller.text,
                    user.uid,
                    user.Username,
                    user.profile);
                    setState(() {
                      _commentcontroller.text="";
                    });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  "Post",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
