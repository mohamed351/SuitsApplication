import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/auth_provider.dart';
import 'package:shopping/providers/products_provider.dart';
import 'package:shopping/screens/auth_screen.dart';
import 'package:shopping/screens/product_details_screen.dart';
import 'package:shopping/screens/product_list_screen.dart';
import 'package:shopping/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductProvider>(
          update: (context, value, previous) =>
              ProductProvider(value.token.toString()),
          create: (_) => ProductProvider(""),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          home: auth.isAuth
              ? ProductListScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : auth.isAuth == true
                              ? ProductListScreen()
                              : AuthScreen(),
                ),
          routes: {
            ProductListScreen.routerName: (context) => ProductListScreen(),
            AuthScreen.routeName: (context) => AuthScreen(),
            SplashScreen.routerName: (context) => SplashScreen(),
            ProductDetail.routerName: (context) => ProductDetail()
          },
        ),
      ),
    );
  }
}
