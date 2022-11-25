// ignore: file_names
import 'package:flutter/material.dart';
import '../constaint/constaint.dart';
import '../models/invoice_list.dart';
import '../models/invoice_submit.dart';
import 'package:http/http.dart' as http;

class InvoiceProvider with ChangeNotifier {
  String token;
  List<InvoiceList> _invoiceList = [];
  List<InvoiceList> get invoiceList {
    return [..._invoiceList];
  }

  InvoiceProvider(this.token);

  Future<List<InvoiceList>> getInvoice() async {
    var response = await http.get(Uri.parse("${Constaint.baseURL}/api/Invoice"),
        headers: {"Authorization": "Bearer " + this.token});
    _invoiceList.clear();
    if (response.statusCode == 200) {
      print(response.body);
      _invoiceList = InvoiceListFromJson(response.body);
      notifyListeners();
      return _invoiceList;
    }
    return [];
  }

  Future<bool> SubmitInvoice(InvoiceSubmit invoiceSubmit) async {
    try {
      var response = await http.post(
          Uri.parse("${Constaint.baseURL}/api/Invoice"),
          headers: {
            "Authorization": "Bearer ${token}",
            "Content-Type": "application/json"
          },
          body: invoiceSubmitToJson(invoiceSubmit));
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
