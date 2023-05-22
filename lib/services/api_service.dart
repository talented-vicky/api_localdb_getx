import 'package:http/http.dart' as http;

import '../models/post.dart';
import '../models/user.dart';

class ApiService {
  var client = http.Client();

  Future<List<Post>?> getPosts() async {
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    final resp = await client.get(uri);
    // print((resp.body).runtimeType); // actually comes as a string of list
    if (resp.statusCode != 200) {
      throw Error();
    }
    return postFromJson(resp.body);
  }

  Future<List<User>> getUsers() async {
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/users");
    final resp = await client.get(uri);
    if (resp.statusCode != 200) {
      throw Error();
    }
    return userFromJson(resp.body);
  }
}
