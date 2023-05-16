import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:api_loacaldb_getx/utils/db_const.dart';
import 'package:api_loacaldb_getx/models/user.dart';
import 'package:api_loacaldb_getx/models/post.dart';

class DBHandler {
  DBHandler._privateController();
  final dbInstance = DBHandler._privateController();

  static Database? _database;

  final _userDBversion = 1;
  final _postDBversion = 1;

  final _userDBName = 'user_db.db';
  final _postDBName = 'post_db.db';

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
    final String path = await getDatabasesPath();
    WidgetsFlutterBinding.ensureInitialized();
    // calling this method because I need the binding to be
    // initialized before calling runApp
    return openDatabase(join(path, _userDBName),
        onCreate: _createUserDB, version: _userDBversion);
  }

  Future<Database> initPostDB() async {
    final String path = await getDatabasesPath();
    return openDatabase(join(path, _postDBName),
        onCreate: _createPostDB, version: _postDBversion);
  }

  Future<void> _createUserDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE ${PostUserConst.userTableName} (${PostUserConst.userId} INTEGER PRIMARY KEY, ${PostUserConst.username} TEXT NOT NULL, ${PostUserConst.name} TEXT NOT NULL, ${PostUserConst.email} TEXT NOT NULL, ${PostUserConst.phone} TEXT NOT NULL, ${PostUserConst.street} TEXT NOT NULL, ${PostUserConst.city} TEXT NOT NULL, ${PostUserConst.zipcode} TEXT NOT NULL, ${PostUserConst.lat} TEXT NOT NULL, ${PostUserConst.lng} TEXT NOT NULL, ${PostUserConst.companyName} TEXT NOT NULL, ${PostUserConst.bs} TEXT NOT NULL, ${PostUserConst.catchPhrase} TEXT NOT NULL)',
    );
  }

  Future<void> _createPostDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE ${PostUserConst.postTableName} (${PostUserConst.postId} INTEGER PRIMARY KEY, ${PostUserConst.title} INTEGER PRIMARY KEY, ${PostUserConst.body} INTEGER PRIMARY KEY)',
    );
  }

  // FETCHING ALL user/post data
  Future<List<User>> getUsers() async {
    final Database db = await userDatabase;
    List<Map<String, dynamic>> userMap =
        await db.query(PostUserConst.userTableName);
    return List.generate(
        userMap.length, (int ind) => User.fromJson(userMap[ind]));
  }

  Future<List<Post>> getPosts() async {
    final Database db = await postDatabase;
    List<Map<String, dynamic>> postMap =
        await db.query(PostUserConst.postTableName);
    return List.generate(
        postMap.length, (int ind) => Post.fromJson(postMap[ind]));
  }

  // FETCHING single user/post data
  Future<User?> getUser(
      {required String queryName, required dynamic queryValue}) async {
    final Database db = await userDatabase;

    List<Map<String, dynamic>> userMap = await db.query(
      PostUserConst.userTableName,
      columns: [
        PostUserConst.userId,
        PostUserConst.username,
        PostUserConst.name,
        PostUserConst.email,
        PostUserConst.phone,
        PostUserConst.street,
        PostUserConst.city,
        PostUserConst.zipcode,
        PostUserConst.lat,
        PostUserConst.lng,
      ],
      where: "$queryName = ?",
      whereArgs: [queryValue],
    );

    if (userMap.isEmpty) {
      return null;
    } else {
      return User.fromJson(userMap.first);
    }
  }

  Future<Post?> getPost(
      {required String querytitle, required dynamic queryValue}) async {
    final Database db = await postDatabase;
    List<Map<String, dynamic>> postMap = await db.query(
      PostUserConst.postTableName,
      columns: [
        PostUserConst.postId,
        PostUserConst.title,
        PostUserConst.body,
      ],
      where: '$querytitle ? =',
      whereArgs: [queryValue],
    );
    if (postMap.isEmpty) {
      return null;
    } else {
      return Post.fromJson(postMap.first);
    }
  }

  // INSERTING user & post data
  Future<int> insertUser(User user) async {
    final Database db = await userDatabase;
    return await db.insert(
      PostUserConst.userTableName,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertPost(Post post) async {
    final Database db = await postDatabase;
    return await db.insert(
      PostUserConst.postTableName,
      post.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // UPDATING user & post data
  Future<int> updateUser({
    required User user,
    required String? userName,
    required dynamic userArg,
  }) async {
    final Database db = await userDatabase;
    return await db.update(
      PostUserConst.userTableName,
      user.toJson(),
      where: userName != null ? '$userName ? =' : null,
      whereArgs: userArg != null ? [userArg] : null,
    );
  }

  Future<int> updatePost({
    required Post post,
    required String? postName,
    required dynamic postArg,
  }) async {
    final Database db = await postDatabase;
    return await db.update(
      PostUserConst.postTableName,
      post.toJson(),
      where: postName != null ? '$postName ?=' : null,
      whereArgs: postArg != null ? [postArg] : null,
    );
  }

  // DELETING user & post data
  Future deleteUser(
      {required User user,
      required String? userName,
      required dynamic userArg}) async {
    final Database db = await userDatabase;
    return await db.delete(
      PostUserConst.userTableName,
      where: userName != null ? '$userName ? =' : null,
      whereArgs: userArg != null ? [userArg] : null,
    );
  }
}
