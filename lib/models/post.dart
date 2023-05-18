import 'dart:convert';

List<Post> postFromJson(String val) =>
    List<Post>.from(json.decode(val).map((result) => Post.fromJson(result)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((result) => result.toJson())));

class Post {
  int userId, id;
  String title, body;

  Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  // for retrieving from database (from json to Post Class datatype)
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"]);
  }

  // for inserting into database (from Post class to json datatype)
  Map<String, dynamic> toJson() {
    return {
      "userId": userId, "id": id,
      "title": title, "body": body
      // values from this function are variables from Post model
    };
  }
}
