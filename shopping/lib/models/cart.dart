import 'dart:convert';

List<Cart> CartFromJson(String str) => List<Cart>.from(
    (json.decode(str) as List<dynamic>).map((e) => Cart.fromJson(e)));

class Cart {
  double? purchasingPriceForPublic;
  double? purchasingPriceForSales;
  int? productId;
  int? quantity;
  double? totalSales;
  double? totalPublich;
  String? imageUrl;
  String? arabicName;
  String? englishName;

  Cart(
      {required this.purchasingPriceForPublic,
      required this.purchasingPriceForSales,
      required this.productId,
      required this.quantity,
      required this.totalPublich,
      required this.totalSales,
      required this.imageUrl,
      required this.arabicName,
      required this.englishName});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["productID"] = productId;
    data["quantity"] = quantity;
    data["totalSales"] = totalSales;
    data["totalPublich"] = totalPublich;
    data["imageUrl"] = imageUrl;
    data["arabicName"] = arabicName;
    data["englishName"] = englishName;
    data["purchasingPriceForPublic"] = purchasingPriceForPublic;
    data["purchasingPriceForSales"] = purchasingPriceForSales;
    return data;
  }

  Cart.fromJson(Map<String, dynamic> json) {
    productId = json["productID"];
    quantity = json["quantity"];
    totalSales = json["totalSales"];
    totalPublich = json["totalPublich"];
    imageUrl = json["imageUrl"];
    arabicName = json["arabicName"];
    englishName = json["englishName"];
    purchasingPriceForPublic = json["purchasingPriceForPublic"];
    purchasingPriceForSales = json["purchasingPriceForSales"];
  }
}
