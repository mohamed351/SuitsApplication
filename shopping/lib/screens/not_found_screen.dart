import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  static const routerName = "/not-found";
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Center(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Not Found",
              style: TextStyle(fontSize: 35),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed("/");
                },
                child: Text("Back to Home"))
          ],
        ))),
      ),
    );
  }
}
