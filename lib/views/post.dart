import 'package:flutter/material.dart';

import 'package:api_loacaldb_getx/services/api_service.dart';
import 'package:api_loacaldb_getx/models/post.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Post>? post;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    _postData();
  }

  void _postData() async {
    post = await ApiService().getPosts();
    if (post != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: isLoaded,
        replacement: const CircularProgressIndicator.adaptive(),
        child: ListView.builder(
          itemCount: post?.length,
          itemBuilder: (BuildContext context, int ind) {
            return Column(children: [
              Row(
                children: [
                  const Text(
                    "Title: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    post![ind].title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w300),
                  )
                ],
              ),
              Text(
                post![ind].title,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
