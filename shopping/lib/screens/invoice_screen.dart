import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shopping/providers/invoice_provider.dart';
import 'package:shopping/screens/invoice_details_screen.dart';

class InvoiceScreen extends StatelessWidget {
  static const routerName = "/Invoices";
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Invoices")),
      body: Container(
          child: FutureBuilder(
        future:
            Provider.of<InvoiceProvider>(context, listen: false).getInvoice(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          var invoiceList =
              Provider.of<InvoiceProvider>(context, listen: false).invoiceList;
          return ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        InvoiceDetailsScreen.routerName,
                        arguments: invoiceList[index]);
                  },
                  leading: Text(
                      "(" + invoiceList[index].invoiceNumber.toString() + ")"),
                  title: Text("Total Price:  " +
                      invoiceList[index].totalInvoice.toString() +
                      "LE"),
                ),
              );
            },
            itemCount: invoiceList.length,
          );
        }),
      )),
    );
  }
}
