import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_tales/closet/my_closet.dart';
import 'package:fashion_tales/controllers/services/firestore_methods.dart';
import 'package:fashion_tales/models/user_model.dart';
import 'package:fashion_tales/post_card/comments_screen.dart';
import 'package:fashion_tales/post_card/like_animation.dart';
import 'package:fashion_tales/provider/user_provider.dart';
import 'package:fashion_tales/utils/colors.dart';
import 'package:fashion_tales/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final bool isfeed;
  final snap;
   PostCard({super.key, required this.snap,this.isfeed=false});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentlen=0;
  bool isLikeAnimating=false;
  bool bookmarked=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  
  }
  void deletepost(String postId)async{
    await FirestoreMethods().deletePost(postId);

  }
  void getComments()async{
    try{
      QuerySnapshot snap= await FirebaseFirestore.instance.collection('posts').doc(widget.snap['postId']).collection('comments').get();
   commentlen=snap.docs.length;
    }catch (e){
      showSnackbar(e.toString(), context);
    }
    setState(() {
      
    });
   
  }
  @override
  Widget build(BuildContext context) {
    final UserModel user=Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: EdgeInsets.all(20),
       decoration: BoxDecoration(
           
          borderRadius: BorderRadius.circular(25),
          
          color: Colors.grey[200],
          // boxShadow: [
          //         BoxShadow(
          //           color: Colors.black.withOpacity(0.3),
          //           spreadRadius: 4,
          //           blurRadius: 6,
          //           offset: Offset(0, 2),
          //         ),
          //       ],
        ),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          // boxShadow: [
          //         BoxShadow(
          //           color: Colors.black.withOpacity(0.3),
          //           spreadRadius: 4,
          //           blurRadius: 6,
          //           offset: Offset(0, 2),
          //         ),
          //       ],
        ),
       
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                  .copyWith(right: 0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(widget.snap['profileImage']),
                  ),
                  
                   
                   Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: GestureDetector(
                        onTap: widget.isfeed?  () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyCloset(uid: widget.snap['uid']),)):null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.snap['Username'],
                              
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    )),
                  
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: ListView(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shrinkWrap: true,
                                children: [
                                  'delete',
                                ]
                                    .map((e) => InkWell(
                                          onTap: (){deletepost(widget.snap['postId']);
                                          Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            child: Text(e),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.more_horiz_rounded))
                ],
              ),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              onDoubleTap: ()async{
                await FirestoreMethods().likePost(
                  user.uid,widget.snap['postId'],widget.snap['likes']
                );
                setState(() {
                  isLikeAnimating=true;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    
                      child: Image.network(
                        widget.snap['postUrl'],
                        fit: BoxFit.cover
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isLikeAnimating?1:0,
                
                    child: LikeAnimation(child: const Icon(Icons.favorite,color: Colors.white,size: 100,),
                     isAnimating: isLikeAnimating,
                     duration: const Duration(
                      milliseconds: 400
                     ),
                     onEnd:(){
                      setState(() {
                        isLikeAnimating=false;
                      });
                     },),
                  )]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  LikeAnimation(
                    isAnimating: widget.snap['likes'].contains(user.uid),
                    smallLike: true,
                    child: IconButton(
                        onPressed: () async{
                          await FirestoreMethods().likePost(
                    user.uid,widget.snap['postId'],widget.snap['likes']
                  );
                          
                        },
                        icon: Icon(
                          widget.snap['likes'].contains(user.uid)? Icons.favorite:Icons.favorite_outline,
                          color: widget.snap['likes'].contains(user.uid)? Colors.red:Colors.black,
                          size: 33,
                        )),
                  ),
                  IconButton(
                      onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder:(context) => CommentsScreen(
                        snap: widget.snap,
                      ),)),
                      icon: const Icon(
                        Icons.comment_outlined,
                        size: 30,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        size: 30,
                      )),
                  Expanded(
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                              onPressed: () async{
                                await FirestoreMethods().savePost(user.uid,widget.snap['postId'],widget.snap['bookmarked']);
                                
                               
                              },
                              icon:widget.snap['bookmarked'].contains(user.uid)?Icon(Icons.bookmark):Icon(
                                Icons.bookmark_border_outlined,
                                size: 30,
                              ))))
                ],
              ),
            ),
            //description and comments
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.snap['likes'].length} likes',
                    style:TextStyle(color: Colors.black),
                    
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 8),
                    child: RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            children: [
                          TextSpan(
                              text: widget.snap["Username"],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: '  ${widget.snap['description']}',
                          )
                        ])),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "view all ${commentlen} comments",
                        style: TextStyle(fontSize: 14, color: secondaryColor),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                         widget.snap['datePublished'].substring(0,10),
                      style: TextStyle(fontSize: 14, color: secondaryColor),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

