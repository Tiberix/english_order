import 'package:english_order/models/product.dart';

class ProductItem {
  int quantity;
  final Product? product;
  double price;
  int table;

  ProductItem(
      {required this.quantity,
      required this.product,
      required this.price,
      required this.table});

  void increment() {
    quantity++;
  }
}
