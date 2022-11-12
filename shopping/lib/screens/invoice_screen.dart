import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InvoiceScreen extends StatelessWidget {
  static const routerName = "Invoices";
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Invoices")),
      body: Container(child: Column()),
    );
  }
}
