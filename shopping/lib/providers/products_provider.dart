import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping/models/product_list.dart';
import 'package:http/http.dart' as http;
import "../constaint/constaint.dart";

class ProductProvider with ChangeNotifier {
  int totalRecords = 0;
  int pageIndex = 0;
  List<Product> list = [];
  String token;
  ProductProvider(this.token);

  void addProduct(Product product) {}

  Future<List<Product>> initailLoad(int lenght) async {
    print(token);
    var url = await http.get(
        Uri.parse(Constaint.baseURL +
            "/api/Products?start=${pageIndex * lenght}&lenght=$lenght"),
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
}