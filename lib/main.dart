import 'package:flutter/material.dart';

import 'package:api_loacaldb_getx/nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Stuff',
      debugShowCheckedModeBanner: false,
      home: Nav(),
    );
  }
}
