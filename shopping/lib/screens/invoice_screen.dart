import 'package:flutter/material.dart';
// import 'home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/invoice_provider.dart';
import 'package:shopping/screens/invoice_details_screen.dart';

import '../constaint/constaint.dart';

class InvoiceScreen extends StatefulWidget {
  static const routerName = "/Invoices";
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(tabs: [
          Tab(
            child: Text("UnApproved",
                style: TextStyle(color: Constaint.primaryColor)),
          ),
          Tab(
            child: Text("Approved",
                style: TextStyle(color: Constaint.primaryColor)),
          )
        ], labelColor: Constaint.primaryColor),

        // appBar: AppBar(title: Text("Invoices")),
        body: TabBarView(
          children: [InvoiceUnApproved(), InvoiceApproved()],
        ),
      ),
    );
  }
}

class InvoiceUnApproved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: double.infinity,
        padding: const EdgeInsets.only(top: 15),
        decoration: const BoxDecoration(
          color: Constaint.thirdColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(55),
            topRight: Radius.circular(55),
          ),
        ),
        child: FutureBuilder(
          future:
              Provider.of<InvoiceProvider>(context, listen: false).getInvoice(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            var invoiceList =
                Provider.of<InvoiceProvider>(context, listen: false)
                    .invoiceList;
            return ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 50,
                        width: 300,

                        // margin: EdgeInsets.only(left: 5),
                        // padding: EdgeInsets.all(10),
                        //height: 50,
                        // width: double.infinity,

                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                InvoiceDetailsScreen.routerName,
                                arguments: invoiceList[index]);
                          },
                          leading: Text("(" +
                              invoiceList[index].invoiceNumber.toString() +
                              ")"),
                          title: Text("Total Price:  " +
                              invoiceList[index].totalInvoice.toString() +
                              "LE"),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: invoiceList.length,
            );
          }),
        ));
  }
}

class InvoiceApproved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: double.infinity,
        padding: const EdgeInsets.only(top: 15),
        decoration: const BoxDecoration(
          color: Constaint.thirdColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(55),
            topRight: Radius.circular(55),
          ),
        ),
        child: FutureBuilder(
          future: Provider.of<InvoiceProvider>(context, listen: false)
              .Approved_getInvoice(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            var invoiceList =
                Provider.of<InvoiceProvider>(context, listen: false)
                    .invoiceList;
            return ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 50,
                        width: 300,

                        // margin: EdgeInsets.only(left: 5),
                        // padding: EdgeInsets.all(10),
                        //height: 50,
                        // width: double.infinity,

                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                InvoiceDetailsScreen.routerName,
                                arguments: invoiceList[index]);
                          },
                          leading: Text("(" +
                              invoiceList[index].invoiceNumber.toString() +
                              ")"),
                          title: Text("Total Price:  " +
                              invoiceList[index].totalInvoice.toString() +
                              "LE"),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: invoiceList.length,
            );
          }),
        ));
  }
}
