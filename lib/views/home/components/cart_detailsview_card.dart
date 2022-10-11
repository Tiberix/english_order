import 'package:english_order/components/price.dart';
import 'package:english_order/controllers/bild_controller.dart';
import 'package:english_order/controllers/cart_controller.dart';
import 'package:english_order/models/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:english_order/util/constants.dart';

class CartDetailsViewCard extends StatelessWidget {
  CartDetailsViewCard({
    Key? key,
    required this.productItem,
  }) : super(key: key);

  final ProductItem productItem;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white,
        backgroundImage: getBildURL(productItem.product!.image.toString())
            ? AssetImage(bildPfad + productItem.product!.image)
            : Image.memory(getBildByte(productItem.product!.image)).image,
      ),
      title: Text(
        productItem.product!.title,
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: FittedBox(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Delete',
              onPressed: () {
                context
                    .read<CartController>()
                    .deleteProdukt(productItem.product!.title);
              },
            ),
            Price(
                amount:
                    " ${(productItem.price * productItem.quantity).toStringAsFixed(2)}"),
            Text("(${productItem.quantity})"),
          ],
        ),
      ),
    );
  }
}
