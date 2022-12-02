import 'dart:convert';

import 'package:flutter/material.dart';
import '../constaint/constaint.dart';
import '../models/Cart.dart';
import '../models/adding_cart.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  String token;
  List<Cart> _cart = [];
  CartProvider(this.token);
  List<Cart> get Items {
    return [..._cart];
  }

  int get itemsLength {
    return _cart.length;
  }

  double get totalInvoice {
    double total = 0;
    for (var element in _cart) {
      total += element.totalSales!;
    }
    return total;
  }

  Future<void> GetCart() async {
    try {
      var response = await http.get(Uri.parse("${Constaint.baseURL}/api/Cart"),
          headers: {"Authorization": "Bearer ${token}"});
      print(response);
      if (response.statusCode == 200) {
        _cart = CartFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> AddToCart(AddingCart addingCart) async {
    var response = await http.post(Uri.parse("${Constaint.baseURL}/api/Cart"),
        body: json.encode(addingCart.toJson()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token
        });
    if (response.statusCode == 200) {
      print("rebuild");
      notifyListeners();
    }
  }

  Future<void> DeleteCart(int productId) async {
    print(productId);
    var response = await http.delete(
        Uri.parse("${Constaint.baseURL}/api/Cart/${productId}"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token
        });
    print(response.statusCode);
    if (response.statusCode == 204) {
      _cart.removeWhere((element) => element.productId == productId);
      notifyListeners();
    }
  }

  Future<void> ClearCart() async {
    this.Items.clear();
    this.notifyListeners();
  }
}
