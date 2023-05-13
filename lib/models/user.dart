import 'dart:convert';

List<User> userApiFunction(String val) {
  return List<User>.from(json.decode(val).map((result) {
    return User.fromjson(result);
  }));
}

class User {
  String name, username, email, phone;
  int id;
  Map? address, company;

  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.phone,
      this.address,
      this.company});

  factory User.fromjson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        email: json['email'],
        phone: json['phone'],
        address: json['address'],
        company: json['company']);
  }
  Map<String, dynamic> userToJson() {
    return {
      "id": id,
      "name": name,
      "username": username,
      "email": email,
      "phone": phone,
      "address": address ?? {"city": "downtown", "street": "wall"},
      "company": company ?? {"name": "companyX", "bs": "e-commerce"},
    };
  }
}
