import 'dart:convert';

List<Brand> brandFromJson(String str) =>
    List<Brand>.from(json.decode(str).map((x) => Brand.fromJson(x)));

String brandToJson(List<Brand> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Brand {
  Brand({
    this.brandArabic,
    this.brandEnglish,
    this.imageUrl,
  });

  String? brandArabic;
  String? brandEnglish;
  String? imageUrl;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        brandArabic: json["brandArabic"],
        brandEnglish: json["brandEnglish"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "brandArabic": brandArabic,
        "brandEnglish": brandEnglish,
        "imageUrl": imageUrl,
      };
}
