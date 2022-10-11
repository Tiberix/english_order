import 'package:flutter/material.dart';

class MyDrawer extends Drawer {
  final BuildContext con;

  MyDrawer({Key? key, required this.con})
      : super(
            key: key,
            child: Container(
              color: Colors.green,
              child: ListView(
                children: [
                  const DrawerHeader(
                    child: Center(
                      child: Text(
                        'EzOrder',
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text(
                      'Order',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pushNamed(con, '/');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.article),
                    title: const Text(
                      'Tables',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pushNamed(con, '/Tische');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.menu_book),
                    title: const Text(
                      'Menu',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pushNamed(con, '/InfoScreen');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.image),
                    title: const Text(
                      'My Images',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pushNamed(con, '/Imageloader');
                    },
                  ),
                ],
              ),
            ));
}
