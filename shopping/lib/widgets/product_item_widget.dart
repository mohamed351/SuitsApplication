import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  Product product;
  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(10));
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetail.routerName, arguments: this.product);
      },
      borderRadius: borderRadius,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white),

        child: Column(
          children: [
            Expanded(
              flex: 7,
              // child: Container(
              //     clipBehavior: Clip.hardEdge,
              //     decoration: BoxDecoration(borderRadius: borderRadius),
                  child: Image.network(
                    fit: BoxFit.cover,
                    this.product.imageUrl!,
                  ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                product.englishName!,
                style: const TextStyle(
                  // color: Color(0xFF4C53A5),
                  color: Colors.black87,
                  // fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                product.purchasingPriceForPublic.toString() + "LE",
                style: const TextStyle(
                  color: Colors.black87,
                  // color: Color(0xFF4C53A5),
                  // fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
