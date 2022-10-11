import 'package:english_order/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../util/constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController controll = context.read<CartController>();
    return Container(
      height: headerHeight,
      //color: primaryColor, //Colors.white,
      decoration: BoxDecoration(
        color: primaryColor, // Colors.white,

        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 50,
            color: primaryColor.withOpacity(0.23),
          ),
        ],
      ),
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: const Color(0xFFEAEAEA)),
              ),
              Text(
                "Table ${controll.getTischNr().toString()}",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: const Color(0xFFEAEAEA)),
              ),
            ],
          ),
          IconButton(
            color: const Color(0xFFEAEAEA),
            onPressed: () => Navigator.pushNamed(context, '/Tische'),
            icon: const Icon(Icons.table_restaurant_outlined),
          ),
          IconButton(
            color: const Color(0xFFEAEAEA),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            icon: const Icon(Icons.menu),
          ),
          //const Menu(),
        ],
      ),
    );
  }
}
