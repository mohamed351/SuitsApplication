class AddingCart {
  int productID;
  int quantity;
  AddingCart({required this.productID, required this.quantity});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["productID"] = this.productID;
    data["quantity"] = this.quantity;
    return data;
  }
}
