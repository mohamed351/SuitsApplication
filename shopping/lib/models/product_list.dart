class ProductList {
  List<Product>? data;
  int? recordsFiltered;
  int? recordsTotal;

  ProductList({this.data, this.recordsFiltered, this.recordsTotal});

  ProductList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
      });
    }
    recordsFiltered = json['recordsFiltered'];
    recordsTotal = json['recordsTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['recordsFiltered'] = recordsFiltered;
    data['recordsTotal'] = recordsTotal;
    return data;
  }
}

class Product {
  String? arabicName;
  String? descriptionArabic;
  String? descriptionEnglish;
  String? englishName;
  int? id;
  String? imageUrl;
  double? purchasingPriceForPublic;
  double? purchasingPriceForSales;
  int? quantity;
  double? sellingPrice;
  int? subCategoryID;

  Product(
      {this.arabicName,
      this.descriptionArabic,
      this.descriptionEnglish,
      this.englishName,
      this.id,
      this.imageUrl,
      this.purchasingPriceForPublic,
      this.purchasingPriceForSales,
      this.quantity,
      this.sellingPrice,
      this.subCategoryID});

  Product.fromJson(Map<String, dynamic> json) {
    arabicName = json['arabicName'];
    descriptionArabic = json['descriptionArabic'];
    descriptionEnglish = json['descriptionEnglish'];
    englishName = json['englishName'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    purchasingPriceForPublic = json['purchasingPriceForPublic'];
    purchasingPriceForSales = json['purchasingPriceForSales'];
    quantity = json['quantity'];
    sellingPrice = json['sellingPrice'];
    subCategoryID = json['subCategoryID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['arabicName'] = arabicName;
    data['descriptionArabic'] = descriptionArabic;
    data['descriptionEnglish'] = descriptionEnglish;
    data['englishName'] = englishName;
    data['id'] = id;
    data['imageUrl'] = imageUrl;
    data['purchasingPriceForPublic'] = purchasingPriceForPublic;
    data['purchasingPriceForSales'] = purchasingPriceForSales;
    data['quantity'] = quantity;
    data['sellingPrice'] = sellingPrice;
    data['subCategoryID'] = subCategoryID;
    return data;
  }
}
