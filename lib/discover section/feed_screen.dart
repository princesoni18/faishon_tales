import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_tales/closet/my_closet.dart';
import 'package:fashion_tales/discover%20section/search_list.dart';
import 'package:fashion_tales/post_card/post_card.dart';

import 'package:flutter/material.dart';

class MyFeed extends StatefulWidget {
  const MyFeed({super.key});

  @override
  State<MyFeed> createState() => _MyFeedState();
}

class _MyFeedState extends State<MyFeed> {
  bool isShowUsers = false;
  final TextEditingController textEditingController = TextEditingController();
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.sort)],
        title: TextFormField(
          controller: textEditingController,
          decoration: const InputDecoration(
            icon: Icon(Icons.search_rounded),
            labelText: "Search for a user ",
          ),
          onFieldSubmitted: (String s) {
            setState(() {
              isShowUsers = true;
            });
          },
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('Username',
                      isGreaterThanOrEqualTo: textEditingController.text)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const  Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyCloset(uid:  (snapshot.data! as dynamic).docs[index]
                                  ['uid']),)),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              (snapshot.data! as dynamic).docs[index]
                                  ['profile']),
                        ),
                        title: Text((snapshot.data! as dynamic).docs[index]
                            ['Username']),
                      );
                    });
              })
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 4),
                      height: 70,
                      child: MySearchList()),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: PostCard(
                              snap: snapshot.data!.docs[index],
                              isfeed: true,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
