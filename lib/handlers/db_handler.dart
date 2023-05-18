import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:api_loacaldb_getx/models/user.dart';
import 'package:api_loacaldb_getx/models/post.dart';

class DBHandler {
  DBHandler._privateController();
  static final dbInstance = DBHandler._privateController();

  static Database? _database;

  final _userDBversion = 1;
  final _postDBversion = 1;

  final _userDBName = 'user_db.db';
  final _postDBName = 'post_db.db';

  final userTableName = 'USERS';
  final postTableName = 'POSTS';

  // ensuring I don't recreate existing database
  Future<Database> get userDatabase async {
    if (_database != null) return _database!;
    _database = await initUserDB();
    return _database!;
  }

  Future<Database> get postDatabase async {
    if (_database != null) return _database!;
    _database = await initPostDB();
    return _database!;
  }

  Future<Database> initUserDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, _userDBName);

    return await openDatabase(
      path,
      version: _userDBversion,
      onCreate: _createUserDB,
    );
  }

  Future<Database> initPostDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, _postDBName);
    return await openDatabase(
      path,
      onCreate: _createPostDB,
      version: _postDBversion,
    );
  }

  Future<void> _createUserDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $userTableName (" "id INTEGER PRIMARY KEY," "username TEXT NOT NULL," "name TEXT NOT NULL," "email TEXT NOT NULL," "phone TEXT NOT NULL," "website TEXT NOT NULL," "street TEXT NOT NULL," "city TEXT NOT NULL," "zipcode TEXT NOT NULL," "suite TEXT NOT NULL," "lat TEXT NOT NULL," "lng TEXT NOT NULL," "name TEXT NOT NULL," "bs TEXT NOT NULL," "catchPhrase TEXT NOT NULL",)")',
    );
  }

  Future<void> _createPostDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $postTableName (" "id integer primary key," "userId INTEGER NOT NULL," "title TEXT NOT NULL," "body TEXT NOT NULL," ")');
  }

  // FETCHING ALL user/post data
  Future<List<User>> getUsers() async {
    final Database db = await userDatabase;
    List<Map<String, dynamic>> userMap = await db.query(userTableName);
    return List.generate(
        userMap.length, (int ind) => User.fromJson(userMap[ind]));
  }

  Future<List<Post>> getPosts() async {
    final Database db = await postDatabase;
    List<Map<String, dynamic>> postMap = await db.query(postTableName);
    return List.generate(
        postMap.length, (int ind) => Post.fromJson(postMap[ind]));
  }

  // FETCHING single user/post data
  Future<User?> getUser(int userId) async {
    final Database db = await userDatabase;

    List<Map<String, dynamic>> userMap = await db.query(
      userTableName,
      where: "id = ?",
      whereArgs: [userId],
    );
    return userMap.isNotEmpty ? User.fromJson(userMap.first) : null;
  }

  Future<Post?> getPost(int postId) async {
    final Database db = await postDatabase;
    List<Map<String, dynamic>> postMap = await db.query(
      postTableName,
      // columns: [ postId, title, body ], // if I want only these rows
      where: 'id = ?',
      whereArgs: [postId],
    );
    return postMap.isNotEmpty ? Post.fromJson(postMap.first) : null;
  }

  // INSERTING user & post data
  Future<int> insertUser(User user) async {
    final Database db = await userDatabase;
    return await db.insert(
      userTableName,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertPost(Post post) async {
    final Database db = await postDatabase;
    return await db.insert(
      postTableName,
      post.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // UPDATING user & post data
  Future<int> updateUser(User user) async {
    final Database db = await userDatabase;
    return await db.update(
      userTableName,
      user.toJson(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> updatePost(Post post) async {
    final Database db = await postDatabase;
    return await db.update(
      postTableName,
      post.toJson(),
      where: 'id = ?',
      whereArgs: [post.id],
    );
  }

  // DELETING user & post data
  Future deleteUser(int userId) async {
    final Database db = await userDatabase;
    return await db.delete(
      userTableName,
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future deleteUsers() async {
    final Database db = await userDatabase;
    return await db.delete(userTableName);
  }

  deletePost(int postId) async {
    final Database db = await postDatabase;
    return await db.delete(
      postTableName,
      where: "id = ?",
      whereArgs: [postId],
    );
  }

  Future deletePosts() async {
    final Database db = await postDatabase;
    return await db.delete(postTableName);
  }
}
