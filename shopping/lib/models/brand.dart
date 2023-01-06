import 'dart:convert';

List<Brand> brandFromJson(String str) =>
    List<Brand>.from(json.decode(str).map((x) => Brand.fromJson(x)));

String brandToJson(List<Brand> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Brand {
  Brand({this.brandArabic, this.brandEnglish, this.imageUrl, this.id});
  int? id;
  String? brandArabic;
  String? brandEnglish;
  String? imageUrl;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
      brandArabic: json["brandArabic"],
      brandEnglish: json["brandEnglish"],
      imageUrl: json["imageUrl"],
      id: json["id"]);

  Map<String, dynamic> toJson() => {
        "brandArabic": brandArabic,
        "brandEnglish": brandEnglish,
        "imageUrl": imageUrl,
        "id": id
      };
}
