import 'package:flutter/material.dart';

import 'package:api_loacaldb_getx/services/api_service.dart';
import 'package:api_loacaldb_getx/models/user.dart';

import 'package:api_loacaldb_getx/handlers/db_handler.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<User> user = [];
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    _userData();
  }

  void _userData() async {
    user = await ApiService().getUsers();
    if (user.isNotEmpty) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      FutureBuilder<List<User>>(
        future: DBHandler.dbInstance.getUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int ind) {
                User obj = snapshot.data![ind];
                return Dismissible(
                  key: UniqueKey(), 
                  onDismissed: DBHandler.dbInstance.deletePost(obj.id),
                  child: ListTile(
                    title: ,
                    subtitle: ,
                    leading: ,
                  )
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        } ),
      );
  }
}
