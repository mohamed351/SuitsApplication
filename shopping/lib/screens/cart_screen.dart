import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/constaint/constaint.dart';
import 'package:shopping/models/invoice_submit.dart';
import 'package:shopping/providers/cart_provider.dart';
import "package:shopping/providers/invoice_provider.dart";

import '../widgets/cart_card_widget.dart';

class CartScreen extends StatefulWidget {
  static const routerName = "/cartScreen";
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;
  Future<void> SubmitInvoice(BuildContext ctx) async {
    setState(() {
      _isLoading = true;
    });
    try {
      var cartItem = Provider.of<CartProvider>(context, listen: false).Items;
      if (cartItem.length == 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: const Text("Please Add Items"),
          duration: Duration(milliseconds: 1500),
        ));
        return;
      }
      List<InvoiceDetailsSubmit> listOfDetails = [];
      for (var element in cartItem) {
        listOfDetails.add(InvoiceDetailsSubmit(
            id: 0,
            price: element.purchasingPriceForSales,
            productId: element.productId,
            quantity: element.quantity,
            total: 0));
      }
      var result = await Provider.of<InvoiceProvider>(context, listen: false)
          .SubmitInvoice(
              InvoiceSubmit(currencyCode: "EGP", invoiceData: listOfDetails));
      if (result) {
        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          content: const Text("Successfull Please See Invoices"),
          duration: Duration(milliseconds: 1500),
        ));
        Provider.of<CartProvider>(ctx, listen: false).ClearCart();
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          content: const Text("Error Invoice Submittion"),
          duration: Duration(milliseconds: 1500),
        ));
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constaint.primaryColor,
        title: Text("Cart "),
      ),
      bottomNavigationBar: Container(
        color: Constaint.thirdColor,
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "TOTAL:",
                  style: TextStyle(
                    color: Constaint.primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Consumer<CartProvider>(
                  builder: (context, value, child) => Expanded(
                    child: Text(
                      value.totalInvoice.toStringAsFixed(2) + " LE",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Constaint.primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                    color: Constaint.primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            Size(double.infinity, 50))),
                    onPressed: () async {
                      await SubmitInvoice(context);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Submit Invoice ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ))),
          ],
        ),
      ),
      body: Container(
        height: 700,
        padding: const EdgeInsets.only(top: 15),
        decoration: const BoxDecoration(
          color: Constaint.thirdColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(55),
            topRight: Radius.circular(55),
          ),
        ),
        child: FutureBuilder(
          future: Provider.of<CartProvider>(context, listen: true).GetCart(),
          builder: (context, snapshot) {
            var items = Provider.of<CartProvider>(context, listen: false).Items;

            return ListView.builder(
                itemBuilder: (context, index) {
                  return CartCardWidget(
                    cart: items[index],
                  );
                },
                itemCount: items.length);
          },
        ),
      ),
    );
  }
}


// Text(
// // '${items[index].englishName.toString()}\n' ,
// // style: TextStyle(
// // color: Colors.black,
// // fontWeight: FontWeight.w500,
// //
// ),
