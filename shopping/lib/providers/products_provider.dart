import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping/models/product_list.dart';
import 'package:http/http.dart' as http;
import "../constaint/constaint.dart";

class ProductProvider with ChangeNotifier {
  int totalRecords = 0;
  int pageIndex = 0;
  List<Product> list = [];
  List<Product> productSearch = [];
  String token;
  Product? selectedProduct = null;
  String? search;
  ProductProvider(this.token);

  void addProduct(Product product) {}

  Future<List<Product>> initailLoad(int lenght) async {
    var url = await http.get(
        Uri.parse(Constaint.baseURL +
            "/api/Products?start=${pageIndex * lenght}&lenght=$lenght"),
        headers: {"Authorization": "Bearer " + token});

    var productList = ProductList.fromJson(jsonDecode(url.body));

    totalRecords = productList.recordsTotal!;
    for (var element in productList.data!) {
      this.list.add(element);
    }
    pageIndex++;
    return productList.data!;
  }

  Future<List<Product>> GetproductSearch(int lenght, String text) async {
    this.search = text;
    var url = await http.get(
        Uri.parse(Constaint.baseURL +
            "/api/Products?start=${pageIndex * lenght}&lenght=$lenght&search=$text"),
        headers: {"Authorization": "Bearer " + token});

    var productSearch = ProductList.fromJson(jsonDecode(url.body));

    totalRecords = productSearch.recordsTotal!;
    for (var element in productSearch.data!) {
      this.list.add(element);
    }
    pageIndex++;
    return productSearch.data!;
  }

  getSelectedProduct(productId) async {
    var request = await http.get(
        Uri.parse(Constaint.baseURL + "/api/Products/${productId}"),
        headers: {"Authorization": "Bearer " + token});
    this.selectedProduct = Product.fromJson(jsonDecode(request.body));
    notifyListeners();
  }

  getSelectedByBrCode(barCode) async {
    var request = await http.get(
        Uri.parse(Constaint.baseURL + "/api/Products/barCode/${barCode}"),
        headers: {"Authorization": "Bearer " + token});
    if (request.statusCode == 200) {
      this.selectedProduct = Product.fromJson(jsonDecode(request.body));
      notifyListeners();
      return this.selectedProduct;
    } else {
      return null;
    }
  }

  IncreseQuantityByOne() {
    this.selectedProduct!.userQuantity =
        this.selectedProduct!.userQuantity! + 1;
    notifyListeners();
  }

  decreseQuantityByOne() {
    if (this.selectedProduct!.userQuantity == 0) {
      return;
    }
    this.selectedProduct!.userQuantity =
        this.selectedProduct!.userQuantity! - 1;
    notifyListeners();
  }

  void Refresh() {
    pageIndex = 0;
    list = [];
    notifyListeners();
  }
}
