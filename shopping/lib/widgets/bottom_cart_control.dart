import "package:flutter/material.dart";

class BottomCartControl extends StatelessWidget {
  VoidCallback increseQuantity;
  VoidCallback decreseQuantity;
  int quantity = 0;
  VoidCallback submitCart;
  BottomCartControl(
      {required this.increseQuantity,
      required this.decreseQuantity,
      required this.quantity,
      required this.submitCart});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        margin: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                flex: 2,
                child: ElevatedButton(
                    onPressed: submitCart, child: const Text("Add To Cart"))),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Quantity"),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    IconButton(
                        onPressed: increseQuantity, icon: Icon(Icons.add)),
                    Text(quantity.toString()),
                    IconButton(
                        onPressed: decreseQuantity, icon: Icon(Icons.remove))
                  ])
                ],
              ),
            )
          ],
        ));
  }
}
