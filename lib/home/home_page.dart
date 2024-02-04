import 'package:fashion_tales/controllers/services/auth_service.dart';
import 'package:fashion_tales/global.dart';
import 'package:fashion_tales/login_page/login_page.dart';
import 'package:fashion_tales/models/user_model.dart';


import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';


class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final PageController _controller = PageController(initialPage: 2);
late UserModel user;
  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
      
  }
  

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  int _page = 2;
  void navigationTapped(int page) {
    _controller.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListTile(
            title: Text("Log Out"),
            onTap: () async {
              await AuthService().logOutUser();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login_Page(),
                  ));
            },
          ),
        ),
        body: PageView(
          controller: _controller,
          children: homeItems,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(8),
          child: GNav(
            selectedIndex: 2,
              onTabChange: (value) {
                navigationTapped(value);
              },
              color: Colors.grey,
              activeColor: Colors.pinkAccent,
              textSize: 10,
              padding: EdgeInsets.all(12),
              tabBackgroundColor: Color.fromARGB(255, 236, 171, 193),
              tabs: const [
                GButton(
                  icon: Icons.person_2_outlined,
                  text: "My Closet",
                ),
                GButton(
                  icon: Icons.group,
                  text: "Groups",
                ),
                GButton(
                  icon: Icons.home,
                  text: "Discover",
                ),
                GButton(
                  icon: Icons.bookmark_outline_rounded,
                  text: "Saved",
                ),
                GButton(
                  icon: Icons.message_rounded,
                  text: "Chats",
                ),
              ]),
        ));
  }
}
