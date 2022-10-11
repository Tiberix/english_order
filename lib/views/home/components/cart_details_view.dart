import 'package:provider/provider.dart';
import 'package:english_order/util/constants.dart';
import 'package:english_order/controllers/cart_controller.dart';
import 'package:flutter/material.dart';

import 'cart_detailsview_card.dart';

class CartDetailsView extends StatelessWidget {
  const CartDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController controll = context.read<CartController>();
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Order", style: Theme.of(context).textTheme.headline6),
              const Spacer(),
              IconButton(
                onPressed: () {
                  controll.changeHomeState(HomeState.normal);
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ],
          ),
          ...List.generate(
            cart().length,
            (index) => CartDetailsViewCard(productItem: cart()[index]),
          ),
          const SizedBox(height: defaultPadding),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                controll.changeHomeState(HomeState.normal);
                Navigator.pushNamed(context, '/Rechnung');
              },
              child: const Text('Check Out'),
            ),
          )
        ],
      ),
    );
  }
}
