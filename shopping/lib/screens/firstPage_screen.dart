import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/home_provider.dart';

import 'package:shopping/widgets/sub_category_list.dart';

import '../constaint/constaint.dart';
import '../widgets/brands_list_widget.dart';
import '../widgets/category_list_widget.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: " Search here... ",
                                  ),
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.search,
                                size: 27,
                                color: Constaint.primaryColor,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () async {
                                  await scanBarcodeNormal();
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 27,
                                  color: Constaint.primaryColor,
                                ),
                              ),
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

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }
}
