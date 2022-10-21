import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        const DrawerHeader(
          child: Text(""),
          decoration: BoxDecoration(color: Colors.blue),
        ),
        ListTile(
          title: const Text("Logout"),
          leading: Icon(Icons.logout),
          onTap: () async {
            await Provider.of<Auth>(context, listen: false).logout();
          },
        )
      ]),
    );
  }
}
