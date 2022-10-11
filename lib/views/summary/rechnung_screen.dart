import 'package:english_order/components/my_app_bar.dart';
import 'package:english_order/components/my_drawer.dart';
import 'package:english_order/controllers/cart_controller.dart';
import 'package:english_order/views/summary/components/generate_pdf.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class Rechnung extends StatelessWidget {
  const Rechnung(this.title, {Key? key}) : super(key: key);

  static const String routeName = '/Rechnung';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const Rechnung('Check out'),
      settings: const RouteSettings(name: routeName),
    );
  }

  final String title;

  @override
  Widget build(BuildContext context) {
    CartController controll = context.read<CartController>();
    return Scaffold(
      appBar: MyAppBar('Bill'),
      endDrawer: MyDrawer(con: context),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text(
              ('Check out'),
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              controll.checkOut();
              Navigator.pushNamed(context, '/Tische');
            },
          ),
          Expanded(
            child: PdfPreview(
              build: (format) => generatePdf(format, title, controll),
            ),
          ),
        ],
      ),
    );
  }
}
