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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "TITLE: ",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    post![ind].title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w300),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 600,
                child: Text(
                  textAlign: TextAlign.justify,
                  (post![ind].body).replaceAll("\n", " "),
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ]);
          },
        ),
      ),
    );
  }
}
