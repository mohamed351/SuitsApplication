import 'dart:convert';

import 'package:flutter/material.dart';
import '../constaint/constaint.dart';
import '../models/adding_cart.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  String token;
  CartProvider(this.token);

  Future<void> GetCart() async {}

  Future<void> AddToCart(AddingCart addingCart) async {
    print(addingCart.productID);
    print(addingCart.quantity);
    var response = await http.post(Uri.parse("${Constaint.baseURL}/api/Cart"),
        body: json.encode(addingCart.toJson()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token
        });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {}
  }
}
