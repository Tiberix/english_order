import 'package:english_order/controllers/bild_controller.dart';
import 'package:english_order/controllers/cart_controller.dart';
import 'package:flutter/material.dart';

import '../../../util/constants.dart';

class CardShortView extends StatelessWidget {
  const CardShortView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.shopping_cart),
        const SizedBox(width: defaultPadding),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                cart().length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: defaultPadding / 2),
                  child: Hero(
                    tag: cart()[index].product!.title + "_Tag",
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: getBildURL(
                              cart()[index].product!.image.toString())
                          ? AssetImage(bildPfad + cart()[index].product!.image)
                          : Image.memory(
                                  getBildByte(cart()[index].product!.image))
                              .image,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            totalCartItems().toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: primaryColor),
          ),
        )
      ],
    );
  }
}
