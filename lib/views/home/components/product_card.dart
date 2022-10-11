import 'package:english_order/components/fav_btn.dart';
import 'package:english_order/components/price.dart';
import 'package:english_order/controllers/bild_controller.dart';
import 'package:english_order/models/product.dart';
import 'package:flutter/material.dart';

import '../../../util/constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    required this.press,
    required this.heroId,
  }) : super(key: key);

  final Product product;
  final String heroId;

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: const BoxDecoration(
          color: Color(0xFFF7F7F7),
          borderRadius: BorderRadius.all(
            Radius.circular(defaultPadding * 1.25),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 5,
              color: Colors.grey,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: heroId,
                child: Image(
                  image: getBildURL(product.image.toString())
                      ? //Image.file(File('bildPfad + product.image'))
                      //.image
                      AssetImage(bildPfad + product.image)
                      : Image.memory(getBildByte(product.image)).image,
                ),
              ),
              Text(
                product.title,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Price(amount: "${product.preis}"),
                  const FavBtn(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
