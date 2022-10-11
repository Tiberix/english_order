import 'package:english_order/components/my_app_bar.dart';
import 'package:english_order/components/price.dart';
import 'package:english_order/controllers/bild_controller.dart';
import 'package:english_order/util/constants.dart';
import 'package:english_order/controllers/cart_controller.dart';
import 'package:english_order/models/product.dart';
import 'package:english_order/views/details/components/rounded_icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.product,
    required this.onProductAdd,
    required this.heroId,
  }) : super(key: key);

  final Product product;
  final VoidCallback onProductAdd;
  final String heroId;
  static const String routeName = '/Details';
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String _cartTag = "";
  int c = 1;

  @override
  Widget build(BuildContext context) {
    CartController controll = context.read<CartController>();
    controll.setQunatity(1);

    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            child: ElevatedButton(
              onPressed: () {
                controll.setQunatity(c);
                widget.onProductAdd();
                setState(() {
                  _cartTag = '_Tag';
                });
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: MyAppBar('Add'),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.37,
              child: Stack(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    color: const Color(0xFFF8F8F8),
                    child: Hero(
                      tag: widget.heroId + _cartTag, //widget.product.title,
                      child: Image(
                        image: getBildURL(widget.product.image.toString())
                            ? AssetImage(bildPfad + widget.product.image)
                            : Image.memory(getBildByte(widget.product.image))
                                .image,
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Row(
                          children: [
                            RoundIconBtn(
                              iconData: Icons.remove,
                              color: Colors.black38,
                              press: () {
                                setState(() {
                                  if (c > 1) {
                                    c--;
                                  }
                                });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: defaultPadding / 4),
                              child: Text(
                                c.toString(),
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w800),
                              ),
                            ),
                            RoundIconBtn(
                              iconData: Icons.add,
                              press: () {
                                setState(() {
                                  c++;
                                });
                              },
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(height: defaultPadding * 1.5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.product.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Price(amount: "${widget.product.preis}"),
                ],
              ),
            ),
            Text(
              widget.product.beschreibung ?? "",
              style: const TextStyle(
                color: Color(0xFFBDBDBD),
                height: 1.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
