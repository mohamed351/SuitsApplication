import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/cart_provider.dart';

import '../screens/cart_screen.dart';

class CartIconWidge extends StatefulWidget {
  const CartIconWidge({super.key});

  @override
  State<CartIconWidge> createState() => _CartIconWidgeState();
}

class _CartIconWidgeState extends State<CartIconWidge> {
  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeContent: FutureBuilder(
        future: Provider.of<CartProvider>(context, listen: true).GetCart(),
        builder: (context, snapshot) => Consumer<CartProvider>(
          builder: (context, value, child) =>
              Text(value.itemsLength.toString()),
        ),
      ),
      position: BadgePosition.topEnd(end: 2, top: 2),
      child: IconButton(
        icon: Icon(Icons.shopping_cart_rounded),
        onPressed: () {
          Navigator.of(context).pushNamed(CartScreen.routerName);
        },
      ),
    );
  }
}
