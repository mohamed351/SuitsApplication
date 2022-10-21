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
    return GridTile(
      child: Image.network(this.product.imageUrl!),
      footer: GridTileBar(
          trailing: IconButton(
            icon: Icon(Icons.shop),
            onPressed: () {},
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                product.englishName!,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                product.purchasingPriceForSales.toString() + "LE",
                textAlign: TextAlign.start,
              )
            ],
          ),
          leading: IconButton(
            icon: Icon(Icons.abc_outlined),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(ProductDetail.routerName, arguments: this.product);
            },
          ),
          backgroundColor: Colors.black45),
    );
  }
}
