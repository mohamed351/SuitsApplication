import 'dart:convert';

invoiceSubmitFromJson(String str) => InvoiceSubmit.fromJson(json.decode(str));

String invoiceSubmitToJson(InvoiceSubmit data) => json.encode(data.toJson());

class InvoiceSubmit {
  InvoiceSubmit({
    this.currencyCode,
    this.invoiceData,
  });

  String? currencyCode;
  List<InvoiceDetailsSubmit>? invoiceData;

  factory InvoiceSubmit.fromJson(Map<String, dynamic> json) => InvoiceSubmit(
        currencyCode: json["currencyCode"],
        invoiceData: List<InvoiceDetailsSubmit>.from(
            json["invoiceData"].map((x) => InvoiceDetailsSubmit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "currencyCode": currencyCode,
        "invoiceData": List<dynamic>.from(invoiceData!.map((x) => x.toJson())),
      };
}

class InvoiceDetailsSubmit {
  InvoiceDetailsSubmit({
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.total,
  });

  int? id;
  int? productId;
  double? price;
  int? quantity;
  int? total;

  factory InvoiceDetailsSubmit.fromJson(Map<String, dynamic> json) =>
      InvoiceDetailsSubmit(
        id: json["id"],
        productId: json["productId"],
        price: json["price"],
        quantity: json["quantity"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "price": price,
        "quantity": quantity,
        "total": total,
      };
}
