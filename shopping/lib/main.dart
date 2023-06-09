import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/auth_provider.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/providers/home_provider.dart';
import 'package:shopping/providers/product_brand_provider.dart';
import 'package:shopping/providers/products_provider.dart';
import 'package:shopping/providers/sub_category_provider.dart';
import 'package:shopping/screens/auth_screen.dart';
import 'package:shopping/screens/cart_screen.dart';
import 'package:shopping/screens/home_screen.dart';
import 'package:shopping/screens/invoice_details_screen.dart';
import 'package:shopping/screens/invoice_screen.dart';
import 'package:shopping/screens/product_brand_screen.dart';
import 'package:shopping/screens/product_details_screen.dart';
import 'package:shopping/screens/product_list_screen.dart';
import 'package:shopping/screens/signUp_screen.dart';
import 'package:shopping/screens/splash_screen.dart';
import "package:shopping/providers/invoice_provider.dart";
import 'package:shopping/screens/sub_category_screen.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// import 'package:shopping/screens/product_List_Screen_try.dart';
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
        ),
        ChangeNotifierProxyProvider<Auth, CartProvider>(
          update: (context, value, previous) =>
              CartProvider(value.token.toString()),
          create: (_) => CartProvider(""),
        ),
        ChangeNotifierProxyProvider<Auth, InvoiceProvider>(
          create: (context) => InvoiceProvider(""),
          update: (context, value, previous) =>
              InvoiceProvider(value.token.toString()),
        ),
        ChangeNotifierProxyProvider<Auth, HomeProvider>(
          create: (context) => HomeProvider(""),
          update: (context, value, previous) =>
              HomeProvider(value.token.toString()),
        ),
        ChangeNotifierProxyProvider<Auth, ProductBrandProvider>(
          create: (context) => ProductBrandProvider(""),
          update: (context, value, previous) =>
              ProductBrandProvider(value.token.toString()),
        ),
        ChangeNotifierProxyProvider<Auth, SubCategoryProvider>(
          create: (context) => SubCategoryProvider(""),
          update: (context, value, previous) =>
              SubCategoryProvider(value.token.toString()),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : auth.isAuth == true
                              ? HomeScreen()
                              : AuthScreen(),
                ),
          routes: {
            HomeScreen.routerName: (context) => HomeScreen(),
            ProductListScreen.routerName: (context) => ProductListScreen(),
            AuthScreen.routeName: (context) => AuthScreen(),
            SplashScreen.routerName: (context) => SplashScreen(),
            ProductDetail.routerName: (context) => ProductDetail(),
            SignupScreen.routerName: (context) => SignupScreen(),
            CartScreen.routerName: (context) => CartScreen(),
            InvoiceScreen.routerName: (context) => InvoiceScreen(),
            InvoiceDetailsScreen.routerName: (context) =>
                InvoiceDetailsScreen(),
            ProductBrandListScreen.routerName: (context) =>
                ProductBrandListScreen(),
            ProductBrandListScreen.routerName: (context) =>
                ProductBrandListScreen(),
            ProductSubCategoryScreen.routerName: (context) =>
                ProductSubCategoryScreen()
          },
        ),
      ),
    );
  }
}
