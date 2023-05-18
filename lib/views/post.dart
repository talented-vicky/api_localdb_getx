import 'package:flutter/material.dart';

import 'package:api_loacaldb_getx/services/api_service.dart';
import 'package:api_loacaldb_getx/models/post.dart';

// import 'package:api_loacaldb_getx/handlers/file_handler.dart';
import 'package:api_loacaldb_getx/handlers/db_handler.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final DBHandler dbHandler = DBHandler.dbInstance;
  // List<Post> postList = [];

  List<Post>? post;
  int ind = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () async {
              post = await ApiService().getPosts();
              final newPost = post![ind];

              await DBHandler.dbInstance.insertPost(newPost);
              setState(() {
                ind += 1;
              });
            },
            child: const Text(
              "Fetch New Post",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder<List<Post>>(
          future: DBHandler.dbInstance.getPosts(),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Post postObj = snapshot.data![index];
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: DBHandler.dbInstance.deleteUser(postObj.id),
                      child: Container(
                          margin: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            bottom: 20,
                          ),
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            color: Colors.blueGrey,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Posted by user: ${postObj.userId.toString()}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 33, 182, 147),
                                  foregroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                                child: const Text(
                                  "Title: ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                (postObj.title).toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 33, 182, 147),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  "Body",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                child: Text(
                                  (postObj.body).replaceAll("\n", " "),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 460),
                                child: ElevatedButton(
                                  onPressed: () {
                                    dbHandler.deletePost(postObj.id);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 33, 182, 147),
                                  ),
                                  child: const Text(
                                    "Remove Post",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          }),
    );
  }
}
