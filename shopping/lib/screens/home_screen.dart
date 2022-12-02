import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/home_provider.dart';
import 'package:shopping/screens/firstPage_Screen.dart';
import 'package:shopping/screens/product_list_screen.dart';
import 'package:shopping/screens/settings_screen.dart';

import '../widgets/app_drawer.dart';
import '../widgets/cart_icon_widget.dart';

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
    {"title": "Settings", "screen": SettingsScreen()}
  ];
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(screens[_page]["title"]),
        actions: [CartIconWidge()],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.settings, size: 30),
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
