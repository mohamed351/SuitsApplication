import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/home_provider.dart';
import 'package:shopping/widgets/sub_category_list.dart';

import '../widgets/brands_list_widget.dart';
import '../widgets/category_list_widget.dart';
import '../widgets/text_field_widget.dart';

class FirstPageHome extends StatelessWidget {
  const FirstPageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<HomeProvider>(context, listen: false).getInitialData(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                const Padding(
                    padding: EdgeInsets.only(left: 15, top: 20),
                    child: Text(
                      "Brands",
                      style: TextStyle(fontSize: 20),
                    )),
                BrandListWidget(),
                const Padding(
                    padding: EdgeInsets.only(left: 15, top: 20),
                    child: Text(
                      "Categories",
                      style: TextStyle(fontSize: 20),
                    )),
                CategoryListWidget(),
                const Padding(
                    padding: EdgeInsets.only(left: 15, top: 20),
                    child: Text(
                      "SubCateogry",
                      style: TextStyle(fontSize: 20),
                    )),
                SubCateogryListWidget()
              ]),
        );
      }),
    );
  }
}
