import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/adding_cart.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/providers/products_provider.dart';

import '../constaint/constaint.dart';
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
  int? quantity = null;
  @override
  Widget build(BuildContext context) {
    final routerArgs = ModalRoute.of(context)?.settings.arguments as int;
    // _cart.productID = routerArgs.id!;

    return Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Constaint.primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                      onPressed: () async {
                        final selectedProduct =
                            Provider.of<ProductProvider>(context, listen: false)
                                .selectedProduct;

                        await Provider.of<CartProvider>(context, listen: false)
                            .SetCart(new AddingCart(
                                productID: selectedProduct!.id!,
                                quantity: selectedProduct!.userQuantity!));
                      },
                      child: Text(
                        "AddToCart",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ))),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Constaint.primaryColor,
          title: Text("Product Details"),
          actions: [CartIconWidge()],
        ),
        body: FutureBuilder(
            future: Provider.of<ProductProvider>(context, listen: false)
                .getSelectedProduct(routerArgs),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final product =
                  Provider.of<ProductProvider>(context, listen: true)
                      .selectedProduct;

              return Container(
                height: 700,
                padding: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  color: Constaint.thirdColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55),
                    topRight: Radius.circular(55),
                  ),
                ),
                width: double.infinity,
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Image.network(
                        product!.imageUrl.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Arc(
                      edge: Edge.TOP,
                      arcType: ArcType.CONVEY,
                      height: 30,
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 50,
                                  bottom: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product.purchasingPriceForSales
                                              .toString() +
                                          "LE",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 10,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Provider.of<ProductProvider>(
                                                      context,
                                                      listen: false)
                                                  .IncreseQuantityByOne();
                                            },
                                            child: Icon(
                                              Icons.add_rounded,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            Provider.of<ProductProvider>(
                                                    context,
                                                    listen: true)
                                                .selectedProduct!
                                                .userQuantity
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Constaint.primaryColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 10,
                                              ),
                                            ],
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Provider.of<ProductProvider>(
                                                      context,
                                                      listen: false)
                                                  .decreseQuantityByOne();
                                            },
                                            child: Icon(
                                              Icons.remove,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        product.englishName!,
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      SingleChildScrollView(
                                        child: Container(
                                          child:
                                              Text(product.descriptionEnglish!),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
