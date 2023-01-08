import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/home_provider.dart';

import 'package:shopping/widgets/sub_category_list.dart';

import '../constaint/constaint.dart';
import '../widgets/brands_list_widget.dart';
import '../widgets/category_list_widget.dart';

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
        return Scaffold(
          body: ListView(
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 700,
                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: Constaint.thirdColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(55),
                      topRight: Radius.circular(55),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              height: 50,
                              width: 300,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: " Search here... ",
                                ),
                              ),
                            ),
                            Icon(
                              Icons.camera_alt,
                              size: 27,
                              color: Constaint.primaryColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: Text(
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
