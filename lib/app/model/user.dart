// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String? userId;
  final String? email;
  final String? fullName;
  final String? role;

  User({
    this.userId,
    this.email,
    this.fullName,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        email: json["email"],
        fullName: json["full_name"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "email": email,
        "full_name": fullName,
        "role": role,
      };
}
