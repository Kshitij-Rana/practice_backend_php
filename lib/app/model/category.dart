// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  final String? categoryId;
  final String? categoryTitle;

  Welcome({
    this.categoryId,
    this.categoryTitle,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        categoryId: json["category_id"],
        categoryTitle: json["category_title"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_title": categoryTitle,
      };
}
