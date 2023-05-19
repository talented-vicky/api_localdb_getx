import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:api_loacaldb_getx/services/api_service.dart';
import 'package:api_loacaldb_getx/models/post.dart';
import 'package:api_loacaldb_getx/controllers/view_state_ctrl.dart';

// import 'package:api_loacaldb_getx/handlers/file_handler.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Post>? post = [];
  // var isLoaded = false;
  final viewCtrl = Get.put(ViewStateCtrl());

  @override
  void initState() {
    super.initState();
    _postData();
  }

  void _postData() async {
    post = await ApiService().getPosts();
    if (post != null) {
      setState(() {
        // isLoaded = true;
        viewCtrl.changeVisb();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => Visibility(
        visible: viewCtrl.visb.value,
        replacement: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Loading..."),
                SizedBox(
                  height: 10,
                ),
                CircularProgressIndicator.adaptive(),
              ]),
        ),
        child: ListView.builder(
          itemCount: post?.length,
          itemBuilder: (BuildContext context, int ind) {
            return Container(
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
                      "Posted by user: ${post![ind].userId.toString()}",
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
                      (post![ind].title).toUpperCase(),
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
                        (post![ind].body).replaceAll("\n", " "),
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
                        onPressed: () {},
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
                ));
          },
        ),
      ),
    ));
  }
}
