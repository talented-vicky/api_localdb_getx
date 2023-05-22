import 'dart:convert';

// a function that expects a list of string (but is actually json obj)
List<User> userFromJson(String val) =>
    List<User>.from(json.decode(val).map((result) => User.fromJson(result)));

// IMPORTANT json codec methods
// decoding is 4rm string to object, so the function type is Map/"User"
// ENCODING is map => string, hence function type must be string

// a function expecting a list of User model features (which is a json) I defined
String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((result) => result.toJson())));

class User {
  int id;
  String name, username, email, phone, website;
  Address address;
  Company company;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.company,
  });

  // this is a "method" expecting json obj as parameter
  factory User.fromJson(Map<String, dynamic> jsonObj) {
    return User(
      id: jsonObj['id'],
      name: jsonObj['name'],
      username: jsonObj['username'],
      email: jsonObj['email'],
      phone: jsonObj['phone'],
      website: jsonObj['website'],
      address: Address.fromJson(jsonObj['address']),
      company: Company.fromJson(jsonObj['company']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "username": username,
      "email": email,
      "phone": phone,
      "website": website,
      "address": address.toJson(),
      "company": company.toJson(),
    };
  }
}

// Address Class
class Address {
  String street, city, zipcode, suite;
  Geo geo;
  Address({
    required this.street,
    required this.city,
    required this.zipcode,
    required this.suite,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json["street"],
      city: json["city"],
      zipcode: json["zipcode"],
      suite: json["suite"],
      geo: Geo.fromJson(json["geo"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "street": street,
      "city": city,
      "zipcode": zipcode,
      "suite": suite,
      "geo": geo.toJson(),
    };
  }
}

// Company Class
class Company {
  String name, bs, catchPhrase;
  Company({required this.name, required this.bs, required this.catchPhrase});

  factory Company.fromJson(json) => Company(
        name: json["name"],
        bs: json["bs"],
        catchPhrase: json["catchPhrase"],
      );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "bs": bs,
      "catchPhrase": catchPhrase,
    };
  }
}

// Geolocation Class
class Geo {
  String lat, lng;
  Geo({required this.lat, required this.lng});

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
        lat: json["lat"],
        lng: json["lng"],
      );
  Map<String, dynamic> toJson() {
    return {
      "lat": lat,
      "lng": lng,
    };
  }
}
