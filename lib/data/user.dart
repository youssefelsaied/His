// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String username;
  String role;
  int id;

  User({
    required this.username,
    required this.role,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["Username"],
        role: json["Role"],
        id: json["Id"],
      );

  Map<String, dynamic> toJson() => {
        "Username": username,
        "Role": role,
        "Id": id,
      };
}
