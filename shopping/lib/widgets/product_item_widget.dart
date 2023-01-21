import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/providers/products_provider.dart';
import 'package:shopping/screens/product_details_screen.dart';

import '../constaint/constaint.dart';

class ProductItem extends StatelessWidget {
  Product product;
  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(10));
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetail.routerName, arguments: this.product.id);
      },
      borderRadius: borderRadius,
      child: Container(
        // margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(borderRadius: borderRadius),
                  child: Image.network(
                    fit: BoxFit.cover,
                    this.product.imageUrl!,
                  )),
            ),
            Expanded(
              flex: 2,
              child: Text(
                product.englishName!,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.purchasingPriceForPublic.toString() + "LE",
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Icon(
                      Icons.add_shopping_cart,
                      color: Constaint.secondaryColor,
                      size: 35,
                    ),

                    // Row(
                    //   children: [
                    //     Container(
                    //       padding: EdgeInsets.all(4),
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(20),
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: Colors.grey.withOpacity(0.5),
                    //             spreadRadius: 1,
                    //             blurRadius: 10,
                    //             offset: Offset(0, 3),
                    //           ),
                    //         ],
                    //       ),
                    //       child: Icon(
                    //         Icons.add_rounded,
                    //         size: 15,
                    //       ),
                    //     ),
                    //     Container(
                    //       margin: EdgeInsets.symmetric(horizontal: 10),
                    //       child: Text(
                    //         "000",
                    //         style: TextStyle(
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.bold,
                    //           color: Constaint.primaryColor,
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       padding: EdgeInsets.all(4),
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(20),
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: Colors.grey.withOpacity(0.5),
                    //             spreadRadius: 1,
                    //             blurRadius: 10,
                    //           ),
                    //         ],
                    //       ),
                    //       child: Icon(
                    //         Icons.remove,
                    //         size: 15,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
