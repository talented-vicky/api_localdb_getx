import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'package:api_loacaldb_getx/models/user.dart';
import 'package:api_loacaldb_getx/models/post.dart';

class FileHandler {
  FileHandler._privateConstructor();
  static final fhInstance = FileHandler._privateConstructor();

  static File? _file;

  final _userFileName = 'user.txt';
  final _postFileName = 'post.txt';

  // creating a getter function (b'cos I'm saving stuff into file)
  Future<File> get userFile async {
    if (_file != null) return _file!;
    _file = await _initUserFile();
    return _file!;
  }

  Future<File> get postFile async {
    if (_file != null) return _file!;
    _file = await _initPostFile();
    return _file!;
  }

  Future<File> _initUserFile() async {
    Directory dir = await getApplicationDocumentsDirectory();
    final String path = dir.path;
    return File('$path/$_userFileName');
  }

  Future<File> _initPostFile() async {
    Directory dir = await getApplicationDocumentsDirectory();
    final path = dir.path;
    return File('$path/$_postFileName');
  }

  final Set<User> _userSet = {};
  final Set<Post> _postSet = {};

  // WRITING users and posts
  Future<void> writeUser(User user) async {
    final File fl = await userFile;
    _userSet.add(user);

    final userList = _userSet.map((e) => e.toJson()).toString();
    // jsonEncode cannot act on "set" but "list"
    await fl.writeAsString(jsonEncode(userList));
  }

  Future<void> writePost(Post post) async {
    final File fl = await postFile;
    _postSet.add(post);

    final postList = _postSet.map((e) => e.toJson()).toString();
    await fl.writeAsString(jsonEncode(postList));
  }

  // READING users and posts
  Future<List<User>> readUsers() async {
    final File fl = await userFile;
    final body = await fl.readAsString();

    final List<dynamic> userData = jsonDecode(body);
    final List<User> jsonData =
        userData.map((e) => User.fromJson(e as Map<String, dynamic>)).toList();
    return jsonData;
  }

  Future<List<Post>> readPosts() async {
    final File fl = await postFile;
    final body = await fl.readAsString();

    final List<dynamic> postData = jsonDecode(body);
    final List<Post> jsonData =
        postData.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
    return jsonData;
  }

  // UPDATING users and posts
  Future<void> updateUser({required int id, required User userToUpdate}) async {
    _userSet.removeWhere((elem) => elem.id == userToUpdate.id);
    await writeUser(userToUpdate);
  }

  Future<void> updatePost({required int id, required Post postToUpdate}) async {
    _postSet.removeWhere((elem) => elem.id == postToUpdate.id);
    await writePost(postToUpdate);
  }

  // DELETING users and posts
  Future<void> deleteUser(User userToDelete) async {
    final File fl = await userFile;
    // delete found file
    _userSet.removeWhere((elem) => elem == userToDelete);

    // convert the remaining object into string for encoding
    final userList = _userSet.map((e) => e.toJson().toString());
    await fl.writeAsString(jsonEncode(userList));
  }

  Future<void> deletePost(Post postToDelete) async {
    final File fl = await postFile;
    _postSet.removeWhere((elem) => elem == postToDelete);

    final postList = _postSet.map((e) => e.toJson().toString());
    fl.writeAsString(jsonEncode(postList));
  }
}
