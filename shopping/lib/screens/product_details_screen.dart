import 'package:flutter/material.dart';
import 'package:shopping/models/product_list.dart';

import '../widgets/bottom_cart_control.dart';

class ProductDetail extends StatelessWidget {
  int quantity = 0;
  static const routerName = "/productDetails";

  ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routerArgs = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      bottomSheet: BottomCartControl(),
      appBar: AppBar(title: Text("Product Details")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Image.network(
            routerArgs.imageUrl!,
            fit: BoxFit.cover,
          )),
          Expanded(
              child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  routerArgs.englishName!,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  routerArgs.purchasingPriceForSales.toString() + "LE",
                  style: TextStyle(fontSize: 20),
                ),
                Text(routerArgs.descriptionEnglish!)
              ],
            ),
          ))
        ],
      ),
    );
  }
}
