import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/adding_cart.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/providers/cart_provider.dart';

import '../widgets/bottom_cart_control.dart';
import '../widgets/cart_icon_widget.dart';
import 'cart_screen.dart';

class ProductDetail extends StatefulWidget {
  static const routerName = "/productDetails";

  ProductDetail({Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  AddingCart _cart = new AddingCart(productID: 0, quantity: 0);

  @override
  Widget build(BuildContext context) {
    final routerArgs = ModalRoute.of(context)?.settings.arguments as Product;
    _cart.productID = routerArgs.id!;

    return Scaffold(
      bottomSheet: BottomCartControl(
        decreseQuantity: () {
          setState(() {
            if (_cart.quantity >= 1) {
              _cart.quantity--;
            }
          });
        },
        increseQuantity: () {
          setState(() {
            _cart.quantity++;
          });
        },
        quantity: _cart.quantity,
        submitCart: () {
          Provider.of<CartProvider>(context, listen: false).AddToCart(_cart);
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Product Details"),
        actions: [CartIconWidge()],
      ),
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
