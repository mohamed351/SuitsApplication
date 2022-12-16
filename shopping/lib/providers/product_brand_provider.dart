import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constaint/constaint.dart';
import '../models/product_list.dart';

class ProductBrandProvider with ChangeNotifier {
  int totalRecords = 0;
  int pageIndex = 0;
  List<Product> list = [];
  String token;
  int? brandId;
  String? brandName;
  ProductBrandProvider(this.token);

  void addProduct(Product product) {}

  Future<List<Product>> initailLoad(int lenght) async {
    var url = await http.get(
        Uri.parse(Constaint.baseURL +
            "/api/Products/brand/${brandId}?start=${pageIndex * lenght}&lenght=$lenght"),
        headers: {"Authorization": "Bearer " + token});
    print(url.statusCode);
    var productList = ProductList.fromJson(jsonDecode(url.body));
    totalRecords = productList.recordsTotal!;
    for (var element in productList.data!) {
      this.list.add(element);
    }
    pageIndex++;
    return productList.data!;
  }

  void Refresh() {
    pageIndex = 0;
    list = [];
  }
}
