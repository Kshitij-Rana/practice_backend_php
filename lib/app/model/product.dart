// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  final String? productId;
  final String? title;
  final String? category;
  final String? description;
  final String? price;
  final dynamic inStock;
  final String? image;
  final String? categoryId;

  Product({
    this.productId,
    this.title,
    this.category,
    this.description,
    this.price,
    this.inStock,
    this.image,
    this.categoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        title: json["title"],
        category: json["category"],
        description: json["description"],
        price: json["price"],
        inStock: json["in_stock"],
        image: json["image"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "title": title,
        "category": category,
        "description": description,
        "price": price,
        "in_stock": inStock,
        "image": image,
        "category_id": categoryId,
      };
}
