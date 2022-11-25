// To parse this JSON data, do
//
//     final InvoiceList = InvoiceListFromJson(jsonString);

import 'dart:convert';

List<InvoiceList> InvoiceListFromJson(String str) => List<InvoiceList>.from(
    json.decode(str).map((x) => InvoiceList.fromJson(x)));

String InvoiceListToJson(List<InvoiceList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvoiceList {
  InvoiceList(
      {this.id,
      this.invoiceNumber,
      this.isApproved,
      this.isDeleted,
      this.totalInvoice,
      this.details,
      this.invoiceDate,
      this.user,
      this.address});

  int? id;
  int? invoiceNumber;
  bool? isApproved;
  bool? isDeleted;
  double? totalInvoice;
  DateTime? invoiceDate;
  List<Detail>? details;
  String? user;
  String? address;

  factory InvoiceList.fromJson(Map<String, dynamic> json) => InvoiceList(
        id: json["id"],
        invoiceNumber: json["invoiceNumber"],
        isApproved: json["isApproved"],
        isDeleted: json["isDeleted"],
        totalInvoice: json["totalInvoice"],
        invoiceDate: DateTime.parse(json["invoiceDate"]),
        user: json["user"],
        address: json["address"],
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoiceNumber": invoiceNumber,
        "isApproved": isApproved,
        "isDeleted": isDeleted,
        "totalInvoice": totalInvoice,
        "invoiceDate": invoiceDate,
        "user": user,
        "address": address,
        "details": List<dynamic>.from(details!.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    this.englishName,
    this.arabicName,
    this.price,
    this.quantity,
    this.total,
  });

  String? englishName;
  String? arabicName;
  double? price;
  double? quantity;
  double? total;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        englishName: json["englishName"],
        arabicName: json["arabicName"],
        price: json["price"],
        quantity: json["quantity"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "englishName": englishName,
        "arabicName": arabicName,
        "price": price,
        "quantity": quantity,
        "total": total,
      };
}
