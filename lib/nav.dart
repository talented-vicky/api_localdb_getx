import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './views/home.dart';
// import './views/post.dart';
// import './views/user.dart';
import './views/post_temp.dart';
import './views/user_temp.dart';
import './controllers/inc_state_ctrl.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  final incCtrl = Get.put(IncStateCtrl());
  // int ind = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const PostPage(),
    const UserPage(),
  ];

  void _flip(int val) {
    setState(() {
      incCtrl.inc.value = val;
      // ind = val;
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
      // body: _pages[ind],
      body: _pages[incCtrl.inc.value],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: const Color.fromARGB(255, 35, 165, 135),
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: "Posts", icon: Icon(Icons.newspaper_sharp)),
          BottomNavigationBarItem(label: "Users", icon: Icon(Icons.person)),
        ],
        // currentIndex: ind,
        currentIndex: incCtrl.inc.value,
        onTap: _flip,
      ),
    );
  }
}
