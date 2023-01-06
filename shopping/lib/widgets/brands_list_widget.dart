import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/brand.dart';
import 'package:shopping/providers/home_provider.dart';
import 'package:shopping/screens/product_brand_screen.dart';

import '../providers/product_brand_provider.dart';

class BrandListWidget extends StatelessWidget {
  const BrandListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context, listen: false);
    return SizedBox(
      height: 90,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Provider.of<ProductBrandProvider>(context, listen: false)
                    .setBrand(provider.Brands[index].brandEnglish.toString(),
                        provider.Brands[index].id!);
                Navigator.of(context)
                    .pushNamed(ProductBrandListScreen.routerName);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      provider.Brands[index].imageUrl.toString(),
                      width: 100,
                    ),
                  ],
                ),
              ));
        },
        itemCount: provider.Brands.length,
      ),
    );
  }
}
