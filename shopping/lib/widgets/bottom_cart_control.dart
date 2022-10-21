import "package:flutter/material.dart";

class BottomCartControl extends StatelessWidget {
  const BottomCartControl({
    Key? key,
  }) : super(key: key);

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
                    onPressed: () {}, child: Text("Add To Cart"))),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Quantity"),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                    Text("0"),
                    IconButton(onPressed: () {}, icon: Icon(Icons.remove))
                  ])
                ],
              ),
            )
          ],
        ));
  }
}
