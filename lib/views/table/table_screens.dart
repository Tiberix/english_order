import 'package:english_order/components/my_app_bar.dart';
import 'package:english_order/components/my_drawer.dart';
import 'package:english_order/util/constants.dart';
import 'package:flutter/material.dart';

import 'components/table_card.dart';

class Tische extends StatelessWidget {
  const Tische({Key? key}) : super(key: key);
  static const String routeName = '/Tische';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => Tische(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('Tables'),
      //drawer: MyDrawer(con: context),
      endDrawer: MyDrawer(con: context),
      body: Container(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                  //physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  controller: ScrollController(),
                  itemCount: anzahltische,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 150,
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) => TableCard(index: index)),
            ),
          ),
        ),
      ),
    );
  }
}
