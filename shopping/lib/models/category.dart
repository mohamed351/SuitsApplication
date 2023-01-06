// To parse this JSON data, do
//
//     final Category = CategoryFromJson(jsonString);

import 'dart:convert';

List<Category> CategoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String CategoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({this.arabicName, this.englishName, this.imageUrl, this.id});
  int? id;
  String? arabicName;
  String? englishName;
  String? imageUrl;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      arabicName: json["arabicName"],
      englishName: json["englishName"],
      imageUrl: json["imageUrl"],
      id: json["id"]);

  Map<String, dynamic> toJson() => {
        "arabicName": arabicName,
        "englishName": englishName,
        "imageUrl": imageUrl,
        "id": id
      };
}
