import 'package:flutter/material.dart';

import 'package:api_loacaldb_getx/services/api_service.dart';
import 'package:api_loacaldb_getx/models/post.dart';

import 'package:api_loacaldb_getx/handlers/file_handler.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final FileHandler fileHandler = FileHandler.fhInstance;
  List<Post> postList = [];

  List<Post>? post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(children: [
        // buttons
        Row(
          children: [
            // button to read post
            ElevatedButton(
              onPressed: () async {
                final allPost = await fileHandler.readPosts();
                setState(() {
                  postList = allPost;
                });
              },
              child: Row(
                children: const [
                  Icon(Icons.info),
                  Text('Load/Reload Posts'),
                ],
              ),
            ),
            // button to add/update post
            ElevatedButton(
              onPressed: () async {
                post = await ApiService().getPosts();
                int ind = 1;

                if (postList.isEmpty) {
                  final firstPost = post![0];
                  postList.add(firstPost);
                  return await fileHandler.writePost(firstPost);
                }

                final newPost = post![ind];
                postList.add(newPost);

                await fileHandler.writePost(newPost);
                ind += 1;
              },
              child: Container(
                child: Row(
                  children: const [
                    Icon(Icons.add),
                    Text('Add Post'),
                  ],
                ),
              ),
            ),
          ],
        ),
        Column(
          children: postList
              .map(
                (e) => Column(children: [
                  Row(children: [
                    const Text(
                      "TITLE: ",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      e.title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                      width: 600,
                      child: Text(
                        textAlign: TextAlign.justify,
                        (e.body).replaceAll("\n", " "),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      )),
                  const SizedBox(
                    height: 30,
                  )
                ]),
              )
              .toList(),
        ),
      ]),
    ));
  }
}
