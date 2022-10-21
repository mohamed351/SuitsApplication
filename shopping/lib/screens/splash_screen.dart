import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const routerName = "/splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hero(tag: "logo", child:  Container( width: 400, child: Image(image: AssetImage("images/logo.png")))),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
