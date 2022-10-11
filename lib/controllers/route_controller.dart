import 'package:english_order/views/home/home_screen.dart';
import 'package:english_order/views/menu/info_screen.dart';
import 'package:english_order/views/summary/rechnung_screen.dart';
import 'package:english_order/views/table/table_screens.dart';
import 'package:english_order/views/uploadImage/upload_image.dart';
import 'package:flutter/material.dart';

class Approuter {
  static Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case Rechnung.routeName:
        return Rechnung.route();
      case InfoScreen.routeName:
        return InfoScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case Tische.routeName:
        return Tische.route();
      case Imageloader.routeName:
        return Imageloader.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Something Wrong.'),
              ),
            ),
        settings: const RouteSettings(name: '/error'));
  }
}
