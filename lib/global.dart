import 'package:fashion_tales/chats/my_chat.dart';
import 'package:fashion_tales/chats/views/home/home_page.dart';
import 'package:fashion_tales/closet/my_closet.dart';

import 'package:fashion_tales/discover%20section/feed_screen.dart';
import 'package:fashion_tales/groups/create_group.dart';

import 'package:fashion_tales/groups/my_groups.dart';
import 'package:fashion_tales/saved/saved.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

List<Widget> homeItems=[MyCloset(uid: FirebaseAuth.instance.currentUser!.uid,),MyGroup(),MyFeed(),Saved(),Homepage()];