import 'package:http/http.dart' as http;

import 'package:api_loacaldb_getx/models/post.dart';
import 'package:api_loacaldb_getx/models/user.dart';

class ApiService {
  var client = http.Client();

  Future<List<Post>?> getPosts() async {
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    final resp = await client.get(uri);
    if (resp.statusCode != 200) {
      final error = Error();
      error.statusCode = 404;
      throw error;
    }
    return postApiFunction(resp.body);
  }

  Future<List<User>?> getUsers() async {
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/users");
    final resp = await client.get(uri);
    if (resp.statusCode != 200) {
      final error = Error();
      error.statusCode = 404;
      throw error;
    }
    return userApiFunction(resp.body);
  }
}
