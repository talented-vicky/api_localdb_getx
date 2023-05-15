import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset(
        "images/api.jpg",
        width: 700,
        height: 300,
      ),
      const SizedBox(
        height: 10,
      ),
      const Text(
        "Welcome to API",
        style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 10,
      ),
      const Text(
        "Check out free post and user API info from jsonplaceholder",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
      ),
    ]));
  }
}
