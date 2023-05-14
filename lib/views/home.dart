import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Home Page"),
        Row(children: const [
          Text("Welcome Aboard"),
          Text("Arigato!!!"),
          Text("Time well Done, boy")
        ])
      ])),
    );
  }
}
