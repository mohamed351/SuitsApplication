import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/home_provider.dart';
import 'package:shopping/providers/products_provider.dart';
import 'package:shopping/screens/product_details_screen.dart';

import 'package:shopping/widgets/sub_category_list.dart';

import '../constaint/constaint.dart';
import '../widgets/brands_list_widget.dart';
import '../widgets/category_list_widget.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../widgets/topBar.dart';
import 'not_found_screen.dart';

class FirstPageHome extends StatelessWidget {
  const FirstPageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<HomeProvider>(context, listen: false).getInitialData(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          body: ListView(
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 700,
                  padding: const EdgeInsets.only(top: 15),
                  decoration: const BoxDecoration(
                    color: Constaint.thirdColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(55),
                      topRight: Radius.circular(55),
                    ),
                  ),
                  child: Column(
                    children: [
                      TopBarWidge(),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: const Text(
                          "BRANDS",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Constaint.primaryColor,
                          ),
                        ),
                      ),
                      BrandListWidget(),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: Text(
                          "CATEGORIES",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Constaint.primaryColor,
                          ),
                        ),
                      ),
                      CategoryListWidget(),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: Text(
                          "SUBGATEGORY",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Constaint.primaryColor,
                          ),
                        ),
                      ),
                      SubCateogryListWidget(),
                    ],
                  ),
                ),

                // const Padding(
                //     padding: EdgeInsets.only(left: 15, top: 20),
                //     child: Text(
                //       "Categories",
                //       style: TextStyle(fontSize: 20),
                //     )),
                // CategoryListWidget(),
                // const Padding(
                //     padding: EdgeInsets.only(left: 15, top: 20),
                //     child: Text(
                //       "SubCateogry",
                //       style: TextStyle(fontSize: 20),
                //     )),
                // SubCateogryListWidget(),
              ]),
        );
      }),
    );
  }
}
