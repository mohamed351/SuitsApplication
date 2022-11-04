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
        decoration: BoxDecoration(
            borderRadius: borderRadius, color: Colors.grey.shade200),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(borderRadius: borderRadius),
                  child: Image.network(
                    fit: BoxFit.cover,
                    this.product.imageUrl!,
                  )),
            ),
            Expanded(
              flex: 1,
              child: Text(
                product.englishName!,
                style: const TextStyle(
                  color: Colors.purpleAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                product.purchasingPriceForPublic.toString() + "LE",
                style: const TextStyle(
                  color: Colors.purpleAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
