import 'package:flutter/material.dart';

import 'package:api_loacaldb_getx/views/home.dart';
import 'package:api_loacaldb_getx/views/post.dart';
import 'package:api_loacaldb_getx/views/user.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int ind = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const PostPage(),
    const UserPage(),
  ];

  void _flip(int value) {
    setState(() {
      ind = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Icon(
            Icons.accessible_forward_rounded,
            color: Color.fromARGB(255, 27, 63, 82),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            "APICALLS",
            style: TextStyle(
                fontSize: 19,
                letterSpacing: 1.8,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 34, 75, 95)),
          ),
        ]),
      ),
      body: _pages[ind],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.indigoAccent,
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: "Posts", icon: Icon(Icons.newspaper_sharp)),
          BottomNavigationBarItem(label: "Users", icon: Icon(Icons.person)),
        ],
        currentIndex: ind,
        onTap: _flip,
      ),
    );
  }
}
