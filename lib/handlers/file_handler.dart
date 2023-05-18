// import 'dart:io';
// import 'dart:convert';
// import 'package:path_provider/path_provider.dart';

// import 'package:api_loacaldb_getx/models/user.dart';
// import 'package:api_loacaldb_getx/models/post.dart';

// class FileHandler {
//   FileHandler._privateConstructor();
//   static final fhInstance = FileHandler._privateConstructor();

//   static File? _file;

//   final _userFileName = 'user.txt';
//   final _postFileName = 'post.txt';

//   // creating a getter function (b'cos I'm saving stuff into file)
//   Future<File> get userFile async {
//     if (_file != null) return _file!;
//     _file = await _initUserFile();
//     return _file!;
//   }

//   Future<File> get postFile async {
//     if (_file != null) return _file!;
//     _file = await _initPostFile();
//     return _file!;
//   }

//   Future<File> _initUserFile() async {
//     final Directory dir = await getApplicationDocumentsDirectory();
//     final String path = dir.path;
//     return File('$path/$_userFileName');
//   }

//   Future<File> _initPostFile() async {
//     final Directory dir = await getApplicationDocumentsDirectory();
//     final path = dir.path;
//     return File('$path/$_postFileName');
//   }

//   final Set<User> _userSet = {};
//   final Set<Post> _postSet = {};

//   // WRITING users and posts
//   Future<void> writeUser(User user) async {
//     final File fl = await userFile;
//     _userSet.add(user);

//     final userList = _userSet.map((e) => e.toJson()).toString();
//     // jsonEncode cannot act on "set" but "list"
//     await fl.writeAsString(jsonEncode(userList));
//   }

//   Future<void> writePost(Post post) async {
//     final File fl = await postFile;
//     _postSet.add(post);

//     final postList = _postSet.map((e) => e.toJson()).toString();
//     await fl.writeAsString(jsonEncode(postList));
//   }

//   // READING users and posts
//   Future<List<User>> readUsers() async {
//     final File fl = await userFile;
//     final body = await fl.readAsString();

//     final List<dynamic> userData = jsonDecode(body);
//     final List<User> jsonData =
//         userData.map((e) => User.fromJson(e as Map<String, dynamic>)).toList();
//     return jsonData;
//   }

//   Future<List<Post>> readPosts() async {
//     final File fl = await postFile;
//     final body = await fl.readAsString();

//     final List<dynamic> postData = jsonDecode(body);
//     final List<Post> jsonData =
//         postData.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
//     return jsonData;
//   }

//   // UPDATING users and posts
//   Future<void> updateUser({required int id, required User userToUpdate}) async {
//     _userSet.removeWhere((elem) => elem.id == userToUpdate.id);
//     await writeUser(userToUpdate);
//   }

//   Future<void> updatePost({required int id, required Post postToUpdate}) async {
//     _postSet.removeWhere((elem) => elem.id == postToUpdate.id);
//     await writePost(postToUpdate);
//   }

//   // DELETING users and posts
//   Future<void> deleteUser(User userToDelete) async {
//     final File fl = await userFile;
//     // delete found file
//     _userSet.removeWhere((elem) => elem == userToDelete);

//     // convert the remaining object into string for encoding
//     final userList = _userSet.map((e) => e.toJson().toString());
//     await fl.writeAsString(jsonEncode(userList));
//   }

//   Future<void> deletePost(Post postToDelete) async {
//     final File fl = await postFile;
//     _postSet.removeWhere((elem) => elem == postToDelete);

//     final postList = _postSet.map((e) => e.toJson().toString());
//     await fl.writeAsString(jsonEncode(postList));
//   }
// }
















// class DBHandler {
//   DBHandler._privateController();
//   final dbInstance = DBHandler._privateController();

//   static Database? _database;

//   final _userDBversion = 1;
//   final _postDBversion = 1;

//   final _userDBName = 'user_db.db';
//   final _postDBName = 'post_db.db';

//   Future<Database> get userDatabase async {
//     if (_database != null) return _database!;
//     _database = await initUserDB();
//     return _database!;
//   }

//   Future<Database> get postDatabase async {
//     if (_database != null) return _database!;
//     _database = await initPostDB();
//     return _database!;
//   }

//   Future<Database> initUserDB() async {
//     final String path = await getDatabasesPath();
//     WidgetsFlutterBinding.ensureInitialized();
//     // calling this method because I need the binding to be
//     // initialized before calling runApp
//     return await openDatabase(join(path, _userDBName),
//         onCreate: _createUserDB, version: _userDBversion);
//   }

//   Future<Database> initPostDB() async {
//     final String path = await getDatabasesPath();
//     return await openDatabase(join(path, _postDBName),
//         onCreate: _createPostDB, version: _postDBversion);
//   }

//   Future<void> _createUserDB(Database db, int version) async {
//     await db.execute(
//       'CREATE TABLE ${PostUserConst.userTableName} (${PostUserConst.userId} INTEGER PRIMARY KEY, ${PostUserConst.username} TEXT NOT NULL, ${PostUserConst.name} TEXT NOT NULL, ${PostUserConst.email} TEXT NOT NULL, ${PostUserConst.phone} TEXT NOT NULL, ${PostUserConst.street} TEXT NOT NULL, ${PostUserConst.city} TEXT NOT NULL, ${PostUserConst.zipcode} TEXT NOT NULL, ${PostUserConst.lat} TEXT NOT NULL, ${PostUserConst.lng} TEXT NOT NULL, ${PostUserConst.companyName} TEXT NOT NULL, ${PostUserConst.bs} TEXT NOT NULL, ${PostUserConst.catchPhrase} TEXT NOT NULL)',
//     );
//   }

//   Future<void> _createPostDB(Database db, int version) async {
//     await db.execute(
//       'CREATE TABLE ${PostUserConst.postTableName} (${PostUserConst.postId} INTEGER PRIMARY KEY, ${PostUserConst.title} INTEGER PRIMARY KEY, ${PostUserConst.body} INTEGER PRIMARY KEY)',
//     );
//   }

//   // FETCHING ALL user/post data
//   Future<List<User>> getUsers() async {
//     final Database db = await userDatabase;
//     List<Map<String, dynamic>> userMap =
//         await db.query(PostUserConst.userTableName);
//     return List.generate(
//         userMap.length, (int ind) => User.fromJson(userMap[ind]));
//   }

//   Future<List<Post>> getPosts() async {
//     final Database db = await postDatabase;
//     List<Map<String, dynamic>> postMap =
//         await db.query(PostUserConst.postTableName);
//     return List.generate(
//         postMap.length, (int ind) => Post.fromJson(postMap[ind]));
//   }

//   // FETCHING single user/post data
//   Future<User?> getUser(
//       {required String queryName, required dynamic queryValue}) async {
//     final Database db = await userDatabase;

//     List<Map<String, dynamic>> userMap = await db.query(
//       PostUserConst.userTableName,
//       columns: [
//         PostUserConst.userId,
//         PostUserConst.username,
//         PostUserConst.name,
//         PostUserConst.email,
//         PostUserConst.phone,
//         PostUserConst.street,
//         PostUserConst.city,
//         PostUserConst.zipcode,
//         PostUserConst.lat,
//         PostUserConst.lng,
//       ],
//       where: "$queryName = ?",
//       whereArgs: [queryValue],
//     );

//     if (userMap.isEmpty) {
//       return null;
//     } else {
//       return User.fromJson(userMap.first);
//     }
//   }

//   Future<Post?> getPost(
//       {required String querytitle, required dynamic queryValue}) async {
//     final Database db = await postDatabase;
//     List<Map<String, dynamic>> postMap = await db.query(
//       PostUserConst.postTableName,
//       columns: [
//         PostUserConst.postId,
//         PostUserConst.title,
//         PostUserConst.body,
//       ],
//       where: '$querytitle ? =',
//       whereArgs: [queryValue],
//     );
//     if (postMap.isEmpty) {
//       return null;
//     } else {
//       return Post.fromJson(postMap.first);
//     }
//   }

//   // INSERTING user & post data
//   Future<int> insertUser(User user) async {
//     final Database db = await userDatabase;
//     return await db.insert(
//       PostUserConst.userTableName,
//       user.toJson(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<int> insertPost(Post post) async {
//     final Database db = await postDatabase;
//     return await db.insert(
//       PostUserConst.postTableName,
//       post.toJson(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // UPDATING user & post data
//   Future<int> updateUser({
//     required User user,
//     required String? userName,
//     required dynamic userArg,
//   }) async {
//     final Database db = await userDatabase;
//     return await db.update(
//       PostUserConst.userTableName,
//       user.toJson(),
//       where: userName != null ? '$userName ? =' : null,
//       whereArgs: userArg != null ? [userArg] : null,
//     );
//   }

//   Future<int> updatePost({
//     required Post post,
//     required String? postName,
//     required dynamic postArg,
//   }) async {
//     final Database db = await postDatabase;
//     return await db.update(
//       PostUserConst.postTableName,
//       post.toJson(),
//       where: postName != null ? '$postName ?=' : null,
//       whereArgs: postArg != null ? [postArg] : null,
//     );
//   }

//   // DELETING user & post data
//   Future deleteUser(
//       {required User user,
//       required String? userName,
//       required dynamic userArg}) async {
//     final Database db = await userDatabase;
//     return await db.delete(
//       PostUserConst.userTableName,
//       where: userName != null ? '$userName ? =' : null,
//       whereArgs: userArg != null ? [userArg] : null,
//     );
//   }
// }



















// class PostPage extends StatefulWidget {
//   const PostPage({super.key});

//   @override
//   State<PostPage> createState() => _PostPageState();
// }

// class _PostPageState extends State<PostPage> {
//   final DBHandler dbHandler = DBHandler.dbInstance;
//   List<Post> postList = [];

//   List<Post>? post;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       child: Column(children: [
//         // buttons
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // button to read post
//             ElevatedButton(
//               onPressed: () async {
//                 final allPost = await dbHandler.getPosts();
//                 setState(() {
//                   postList = allPost;
//                 });
//               },
//               child: Row(
//                 children: const [
//                   Icon(Icons.info),
//                   Text('Load/Reload Posts'),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             // button to add/update post
//             ElevatedButton(
//               onPressed: () async {
//                 post = await ApiService().getPosts();
//                 int ind = 1;

//                 if (postList.isEmpty) {
//                   final firstPost = post![0];
//                   postList.add(firstPost);
//                   await dbHandler.insertPost(firstPost);
//                   return;
//                 }

//                 final newPost = post![ind];
//                 postList.add(newPost);

//                 await dbHandler.insertPost(newPost);
//                 ind += 1;
//               },
//               child: Container(
//                 child: Row(
//                   children: const [
//                     Icon(Icons.add),
//                     Text('Add Post'),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Column(
//           children: postList
//               .map(
//                 (e) => Column(children: [
//                   Row(children: [
//                     const Text(
//                       "TITLE: ",
//                       style:
//                           TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       e.title,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w300,
//                       ),
//                     ),
//                   ]),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   SizedBox(
//                       width: 600,
//                       child: Text(
//                         textAlign: TextAlign.justify,
//                         (e.body).replaceAll("\n", " "),
//                         style: const TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w300,
//                         ),
//                       )),
//                   const SizedBox(
//                     height: 30,
//                   )
//                 ]),
//               )
//               .toList(),
//         ),
//       ]),
//     ));
//   }
// }
