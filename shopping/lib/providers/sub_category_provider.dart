import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping/models/product_list.dart';

import '../constaint/constaint.dart';
import 'package:http/http.dart' as http;

class SubCategoryProvider with ChangeNotifier {
  int totalRecords = 0;
  int pageIndex = 0;
  List<Product> list = [];
  String token;
  int? subCategoryID;
  String? subCategoryName;
  SubCategoryProvider(this.token);

  Future<List<Product>> initailLoad(int lenght) async {
    var url = await http.get(
        Uri.parse(Constaint.baseURL +
            "/api/Products/subCategory/${subCategoryID}?start=${pageIndex * lenght}&lenght=$lenght"),
        headers: {"Authorization": "Bearer " + token});
    print(url.request!.url);
    var productList = ProductList.fromJson(jsonDecode(url.body));
    totalRecords = productList.recordsTotal!;
    for (var element in productList.data!) {
      this.list.add(element);
    }
    pageIndex++;
    return productList.data!;
  }

  void setSubCategory(String currentsubCategory, int currentsubCategoruID) {
    subCategoryID = currentsubCategoruID;
    subCategoryName = currentsubCategory;
  }

  void Refresh() {
    pageIndex = 0;
    list = [];
  }
}
