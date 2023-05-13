import 'package:flutter/material.dart';

import 'package:api_loacaldb_getx/services/api_service.dart';
import 'package:api_loacaldb_getx/models/user.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<User>? user;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    _userData();
  }

  void _userData() async {
    user = await ApiService().getUsers();
    if (user != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        replacement: const Center(
          heightFactor: 100,
          widthFactor: 100,
          child: CircularProgressIndicator.adaptive(
              // valueColor: Color[ColorScheme.dark(200)],
              ),
        ),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int ind) {
            return Row(children: [
              // icon and nickname
              Column(children: [
                const ImageIcon(
                  AssetImage("images/profile.jpg"),
                  size: 15,
                ),
                Text(
                  user![ind].username,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ]),
              // name, email and company
              Column(children: [
                Text(
                  user![ind].name,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Column(children: [
                  Row(children: [
                    const Text(
                      "Eamil: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user![ind].email,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                  ]),
                  Row(children: [
                    const Text(
                      "Phone: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user![ind].phone,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                  ]),
                ]),
                // company info
                Row(children: [
                  Column(
                    children: [
                      const Text(
                        "Company name",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        user![ind].company!["name"],
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Column(children: [
                    const Text(
                      "Business Keywords",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user![ind].company!["bs"],
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                  ]),
                ]),
              ]),
              // address and others
              Column(children: [
                const Text(
                  "Address",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  user![ind].address!["street"],
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w300),
                ),
                Text(
                  user![ind].address!["city"],
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w300),
                ),
                Text(
                  user![ind].address!["zipcode"],
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w300),
                ),
              ])
            ]);
          },
        ),
      ),
    );
  }
}
