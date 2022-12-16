// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:shopping/providers/cart_provider.dart';
import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/home_provider.dart';
import 'package:shopping/screens/firstPage_Screen.dart';
import 'package:shopping/screens/product_list_screen.dart';
import 'package:shopping/screens/settings_screen.dart';

import '../providers/cart_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/cart_icon_widget.dart';
import 'cart_screen.dart';
import 'invoice_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routerName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;

  static const List<dynamic> screens = [
    {"title": "Home", "screen": FirstPageHome()},
    {"title": "Product List", "screen": ProductListScreen()},
    // {"title": "cart", "screen": CartScreen()},
    {"title": "invoice", "screen": InvoiceScreen()}
    // {"title": "Settings", "screen": SettingsScreen()}
  ];
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF4C53A5),
        title: Text(screens[_page]["title"]),
        // actions: [CartIconWidge()],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Color(0xFF4C53A5),
        height: 70,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          // Badge(
          //   badgeContent: FutureBuilder(
          //     future:
          //         Provider.of<CartProvider>(context, listen: true).GetCart(),
          //     builder: (context, snapshot) => Consumer<CartProvider>(
          //       builder: (context, value, child) =>
          //           Text(value.itemsLength.toString()),
          //     ),
          //   ),
          //   position: BadgePosition.topEnd(end:-15,top:-5),
          //   child: Icon(
          //     Icons.shopping_cart_checkout_outlined,
          //     size: 30,
          //     color: Colors.white,
          //   ),
          // ),
          Icon(
            Icons.list_rounded,
            size: 30,
            color: Colors.white,
          ),

          Icon(
            Icons.inventory,
            size: 30,
            color: Colors.white,
          ),
          // Badge(
          //   badgeContent: FutureBuilder(
          //     future:
          //         Provider.of<CartProvider>(context, listen: true).GetCart(),
          //     builder: (context, snapshot) => Consumer<CartProvider>(
          //       builder: (context, value, child) =>
          //           Text(value.itemsLength.toString()),
          //     ),
          //   ),
          //   position: BadgePosition.topEnd(end: 2, top: 2),
          //   child: (Icon(Icons.shopping_cart_rounded)),
          // ),

          // IconButton(
          //   icon: Icon(Icons.inventory),
          //   onPressed: () async {
          //     Navigator.of(context).pushNamed(InvoiceScreen.routerName);
          //   },
          //   // title: const Text("Invoices"),
          //   // leading:
          //   // onTap:
          // ),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
          //Handle button tap
        },
      ),
      body: screens[_page]["screen"],
    );
  }
}
