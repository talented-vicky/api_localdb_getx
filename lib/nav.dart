import 'package:flutter/material.dart';

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
        title: const Text('API Calls'),
      ),
      body: _pages[ind],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
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
