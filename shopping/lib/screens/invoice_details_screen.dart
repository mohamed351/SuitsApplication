import 'package:flutter/material.dart';
import 'package:shopping/models/invoice_list.dart';
import "package:intl/intl.dart";

class InvoiceDetailsScreen extends StatelessWidget {
  static const routerName = "/invoice-detail";

  const InvoiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var invoice = ModalRoute.of(context)!.settings.arguments as InvoiceList;
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        child: Column(children: [
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(color: Color(0xff1B1822)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Invoice",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "#${invoice.invoiceNumber}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Invoice No"),
                          Text(
                            "${invoice.invoiceNumber}",
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Pharmacy Name"),
                          Text(
                            "${invoice.user}",
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date",
                            textAlign: TextAlign.right,
                          ),
                          Text(
                            "${DateFormat.yMMMd().format(invoice.invoiceDate!)} ",
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Address"),
                          Text(
                            "${invoice.address}",
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  LayoutBuilder(builder: (p0, p1) {
                    ;

                    return Container(
                      height: MediaQuery.of(context).size.height / 1.7,
                      child: SingleChildScrollView(
                        child: Table(
                          border:
                              TableBorder.all(color: Colors.black, width: 1.5),
                          children: [
                            TableRow(children: [
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const Text(
                                    "Product",
                                    textAlign: TextAlign.center,
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const Text(
                                    "Price",
                                    textAlign: TextAlign.center,
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const Text(
                                    "Quantity",
                                    textAlign: TextAlign.center,
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const Text(
                                    "Total",
                                    textAlign: TextAlign.center,
                                  )),
                            ]),
                            ...invoice.details!.map((e) {
                              return TableRow(children: [
                                Container(
                                  // ignore: sort_child_properties_last
                                  child: Text(
                                    e.englishName!,
                                    textAlign: TextAlign.center,
                                  ),
                                  padding: EdgeInsets.all(10),
                                ),
                                Container(
                                  child: Text(
                                    "${e.price!.toStringAsFixed(2)} LE",
                                    textAlign: TextAlign.center,
                                  ),
                                  padding: EdgeInsets.all(10),
                                ),
                                Container(
                                  child: Text(
                                    e.quantity!.toStringAsFixed(0),
                                    textAlign: TextAlign.center,
                                  ),
                                  padding: EdgeInsets.all(10),
                                ),
                                Container(
                                  child: Text(
                                    e.total.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                  padding: EdgeInsets.all(10),
                                )
                              ]);
                            }).toList()
                          ],
                        ),
                      ),
                    );
                  })
                ]),
              ))
        ]),
      )),
    );
  }
}
