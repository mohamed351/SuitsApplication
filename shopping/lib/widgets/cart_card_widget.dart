import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/adding_cart.dart';
import '../../providers/products_provider.dart';

import '../constaint/constaint.dart';
import '../models/Cart.dart';
import '../providers/cart_provider.dart';

class CartCardWidget extends StatelessWidget {
  final Cart cart;
  const CartCardWidget({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Image.network(
              height: 100,
              width: 100,
              cart.imageUrl!,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  RichText(
                    text: TextSpan(
                        text: '',
                        style: TextStyle(
                            color: Constaint.primaryColor, fontSize: 15),
                        children: [
                          TextSpan(
                              text: '${cart.englishName.toString()}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                        ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        maxLines: 1,
                        text: TextSpan(
                            text: 'Unit:  ',
                            style: TextStyle(
                                color: Constaint.primaryColor, fontSize: 15),
                            children: [
                              TextSpan(
                                  text: '${cart.quantity.toString()}\n',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ]),
                      ),
                      RichText(
                        maxLines: 1,
                        text: TextSpan(
                            text: 'Price: ',
                            style: TextStyle(
                                color: Constaint.primaryColor, fontSize: 15),
                            children: [
                              TextSpan(
                                  text:
                                      '${cart.purchasingPriceForSales.toString()}\n',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ]),
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Total:  ',
                            style: TextStyle(
                                color: Constaint.primaryColor, fontSize: 15),
                            children: [
                              TextSpan(
                                  text: '${cart.totalSales.toString()}\n',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ]),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RemoveButton(
                          productId: cart.productId,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            await Provider.of<CartProvider>(context,
                                    listen: false)
                                .AddToCart(AddingCart(
                                    productID: cart.productId!, quantity: 1));
                            Provider.of<ProductProvider>(context, listen: false)
                                .getSelectedProduct(cart.productId);
                            // Provider.of<ProductProvider>(context, listen: true)
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.add_rounded,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          cart.quantity.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Constaint.primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                await Provider.of<CartProvider>(context,
                                        listen: false)
                                    .DeductToCart(AddingCart(
                                        productID: cart.productId!,
                                        quantity: 1));
                                Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .getSelectedProduct(cart.productId);
                              },
                              child: Icon(
                                Icons.remove,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RemoveButton extends StatelessWidget {
  const RemoveButton({Key? key, required this.productId}) : super(key: key);

  final productId;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await Provider.of<CartProvider>(context, listen: false)
            .DeleteCart(productId);
      },
      icon: Icon(Icons.delete, color: Colors.red, size: 25),
    );
  }
}
