import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/brand.dart';
import 'package:shopping/providers/home_provider.dart';

import '../constaint/constaint.dart';
import '../providers/sub_category_provider.dart';
import '../screens/sub_category_screen.dart';

class SubCateogryListWidget extends StatelessWidget {
  const SubCateogryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context, listen: false);
    // return SizedBox(
    //   height: 150,
    //   child: ListView.builder(
    //     shrinkWrap: true,
    //     scrollDirection: Axis.horizontal,
    //     itemBuilder: (context, index) {
    //       return Card(
    //           child: Column(
    //         children: [
    //           Image.network(
    //             provider.SubCateogries[index].imageUrl.toString(),
    //             width: 100,
    //           ),
    //           Text(provider.SubCateogries[index].englishName.toString())
    //         ],
    //       ));
    //     },
    //     itemCount: provider.SubCateogries.length,
    //   ),
    // );

    return Container(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Provider.of<SubCategoryProvider>(context, listen: false)
                  .setSubCategory(
                      provider.SubCateogries[index].englishName.toString(),
                      provider.SubCateogries[index].id!);

              Navigator.of(context)
                  .pushNamed(ProductSubCategoryScreen.routerName);
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
                    provider.SubCateogries[index].imageUrl.toString(),
                    width: 80,
                    height: 80,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    provider.SubCateogries[index].englishName.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Constaint.primaryColor,
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: provider.SubCateogries.length,
      ),
    );
  }
}
