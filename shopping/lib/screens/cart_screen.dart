import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/Cart.dart';
import 'package:shopping/models/cart.dart';
import 'package:shopping/models/invoice_submit.dart';
import 'package:shopping/providers/cart_provider.dart';
import "package:shopping/providers/invoice_provider.dart";

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
      // appBar: AppBar(
      //   backgroundColor: Colors.purple,
      //   title: Text("Cart "),
      // ),
      bottomSheet: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<CartProvider>(
              builder: (context, value, child) => Expanded(
                child: Text(
                  value.totalInvoice.toStringAsFixed(2) + " LE",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.purple, fontSize: 25),
                ),
              ),
            ),
            Expanded(
                child: ElevatedButton(
                    onPressed: () async {
                      await SubmitInvoice(context);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Submit Invoice ",
                      textAlign: TextAlign.center,
                    )))
          ],
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<CartProvider>(context, listen: false).GetCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var items = Provider.of<CartProvider>(context, listen: false).Items;

            return ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                        Image.network(
                          items[index].imageUrl!,
                          width: 80,
                          height: 80,
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5.0,
                              ),
                              RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                text: TextSpan(
                                    text: 'Name: ',
                                    style: TextStyle(
                                        color: Colors.blueGrey.shade800,
                                        fontSize: 16.0),
                                    children: [
                                      TextSpan(
                                          text:
                                              '${items[index].englishName.toString()}\n',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ]),
                              ),
                              RichText(
                                maxLines: 1,
                                text: TextSpan(
                                    text: 'Unit:  ',
                                    style: TextStyle(
                                        color: Colors.blueGrey.shade800,
                                        fontSize: 16.0),
                                    children: [
                                      TextSpan(
                                          text:
                                              '${items[index].quantity.toString()}\n',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ]),
                              ),
                              RichText(
                                maxLines: 1,
                                text: TextSpan(
                                    text: 'Price: ',
                                    style: TextStyle(
                                        color: Colors.blueGrey.shade800,
                                        fontSize: 16.0),
                                    children: [
                                      TextSpan(
                                          text:
                                              '${items[index].purchasingPriceForSales.toString()}\n',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ]),
                              ),
                              RichText(
                                maxLines: 1,
                                text: TextSpan(
                                    text: 'Total:  ',
                                    style: TextStyle(
                                        color: Colors.blueGrey.shade800,
                                        fontSize: 16.0),
                                    children: [
                                      TextSpan(
                                          text:
                                              '${items[index].totalSales.toString()}\n',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ]),
                              )
                            ],
                          ),
                        ),
                        RemoveButton(
                          productId: items[index].productId,
                        )
                      ]));
                },
                itemCount: items.length);
          }
        },
      ),
    );
  }
}

class RemoveButton extends StatelessWidget {
  const RemoveButton({Key? key, required this.productId}) : super(key: key);

  final productId;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.red),
        onPressed: () async {
          await Provider.of<CartProvider>(context, listen: false)
              .DeleteCart(productId);
        },
        child: const Text('Remove'));
  }
}
