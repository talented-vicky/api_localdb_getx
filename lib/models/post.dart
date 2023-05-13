import 'dart:convert';

List<Post> postApiFunction(String val) {
  return List<Post>.from(json.decode(val).map((result) {
    return Post.fromJson(result);
  }));
}

class Post {
  int userId, id;
  String title, body;

  Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"]);
  }
  // Map<String, dynamic> toJson() {
  Map<String, dynamic> postToJson() {
    return {
      "userId": userId, "id": id,
      "title": title, "body": body
      // values from this function are variables from Post model
    };
  }
}
