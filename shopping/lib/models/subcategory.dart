import 'dart:convert';

List<SubCategory> SubCategoryFromJson(String str) => List<SubCategory>.from(
    json.decode(str).map((x) => SubCategory.fromJson(x)));

String SubCategoryToJson(List<SubCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategory {
  SubCategory({
    this.arabicName,
    this.englishName,
    this.imageUrl,
  });

  String? arabicName;
  String? englishName;
  String? imageUrl;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        arabicName: json["arabicName"],
        englishName: json["englishName"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "arabicName": arabicName,
        "englishName": englishName,
        "imageUrl": imageUrl,
      };
}
