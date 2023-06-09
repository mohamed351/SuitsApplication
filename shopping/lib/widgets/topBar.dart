import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import '../constaint/constaint.dart';
import '../providers/products_provider.dart';
import '../screens/not_found_screen.dart';
import '../screens/product_details_screen.dart';
import '../screens/product_search_screen.dart';

class TopBarWidge extends StatefulWidget {
  const TopBarWidge({super.key});

  @override
  State<TopBarWidge> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TopBarWidge> {
  TextEditingController _controller = new TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                controller: _controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: " Search here... ",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: !isLoading
                ? GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await Provider.of<ProductProvider>(context, listen: false)
                          .GetproductSearch(10, this._controller.text);
                      Navigator.of(context)
                          .pushNamed(ProductListSearchScreen.routerName);
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Icon(
                      Icons.search,
                      size: 27,
                      color: Constaint.primaryColor,
                    ),
                  )
                : SizedBox(
                    child: Center(child: CircularProgressIndicator()),
                    height: 20,
                    width: 20),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () async {
                String barCode = await scanBarcodeNormal();
                print(barCode);
                if (barCode != "ERROR") {
                  var product =
                      await Provider.of<ProductProvider>(context, listen: false)
                          .getSelectedByBrCode(barCode);

                  if (product != null) {
                    Navigator.of(context).pushNamed(ProductDetail.routerName,
                        arguments: product.id);
                  } else {
                    Navigator.of(context).pushNamed(NotFound.routerName);
                  }
                }
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
    );
  }

  Future<String> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'ERROR';
    }
    return barcodeScanRes;

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }
}
